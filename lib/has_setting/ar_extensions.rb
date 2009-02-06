module HasSetting
  
  module InstanceMethods
    def write_setting(name, value)
      # find an existing setting or build a new one
      setting = self.settings.detect() {|item| item.name == name }
      setting = self.settings.build(:name => name) if setting.blank?
      setting.value = value
    end
    
    def read_setting(name)
      # use detect instead of SQL find. like this the 'cached' has_many-collection is inited 
      # only once
      self.settings.detect() {|item| item.name == name }
    end
  end
  
  module ClassMethods
    # Setup of the getter/setter
    def has_setting(name, options = {})
      name = name.to_s
      raise ArgumentError.new('Setting name must not be blank') if name.blank?
      
      self.class_eval do
        unless @has_setting_options # define only once
          # AR association to settings
          has_many( :settings, :as => :owner, :class_name => 'HasSetting::Setting', 
                    :foreign_key => :owner_id, :dependent => :destroy)
          after_save(:save_has_setting_association)
          @has_setting_options = {}
          def self.has_setting_options
            @has_setting_options
          end
          
          private
          # Callback to save settings
          def save_has_setting_association
            self.settings.each do |setting|
              if setting.changed?
                setting.save
              end
            end
          end
        end
      end
      
      
      raise ArgumentError.new("Setting #{name }is already defined on #{self.name}") if self.has_setting_options.has_key?(name)
      
      # default options
      options[:type] ||= :string    # treat as string
      options[:default] ||= nil     # no default value
      self.has_setting_options[name] = options
      
      # setter
      define_method("#{name}=".intern) do |value|
        formatter = HasSetting::Formatters.for_type(options[:type])
        write_setting(name, formatter.to_s(value))
      end
      
      # getter
      define_method(name) do |*args|
        setting = read_setting(name)
        options = args.first || self.class.has_setting_options[name]
        return options[:default] if setting.nil? 
        formatter = HasSetting::Formatters.for_type(options[:type])
        formatter.to_type(setting.value)
        #case options[:type]
        #  when :string : setting.value
        #  when :int : setting.value.nil? ? nil : setting.value.to_i
        #  when :float : setting.value.nil? ? nil : setting.value.to_f
        #  else raise ArgumentError.new("Unsupported type: #{options[:type]}")
        #end
      end
    end
  end
end