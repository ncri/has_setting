module HasSetting
  module InstanceMethods
    def write_setting(name, value)
      setting = self.settings.find_or_initialize_by_name(name)
      setting.value = value
      setting.save
      # reload so the getters work on the up-to-date collection
      settings.reload
    end
    
    def read_setting(name)
      # use detect instead of SQL find. like this the 'cached' has_many-collection is inited 
      # only once
      self.settings.detect() {|item| item.name == name }
    end
  end
  
  module ClassMethods
    def self.extended(extender)
      extender.class_eval do
        # AR association to settings
        has_many(:settings, :as => :owner, :class_name => 'HasSetting::Setting', :foreign_key => :owner_id)
        # a hash where we can store options for the settings
        write_inheritable_attribute(:has_setting_options, {})
        class_inheritable_reader(:has_setting_options)
      end
    end
    

    
    #
    # Setup of the getter/setter
    def has_setting(name, options = {})
      options[:type] ||= :string
      name = name.to_s
      raise ArgumentError.new("Setting name must not be blank") if name.blank?
      has_setting_options[name] = options
      
      define_method("#{name}=".intern) do |value|
        value = value.nil? ? nil : value.to_s 
        write_setting("#{self.class.name}.#{name}", value)
      end
      
      # getter
      define_method(name) do |*args| 
        setting = read_setting("#{self.class.name}.#{name}")
        return nil if setting.nil?
        
        options = args.first || has_setting_options[name]
        case options[:type]
          when :string : setting.value
          when :int : setting.value.blank? ? nil : setting.value.to_i
          when :float : setting.value.blank? ? nil : setting.value.to_f
          else raise ArgumentError.new("Unsupported type: #{options[:type]}")
        end
      end
    end
  end
end