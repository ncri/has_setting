module HasSetting
  module InstanceMethods
    def write_setting(name, value)
      # find an existing setting or build a new one
      setting = self.settings.find_by_name(name)
      setting = self.settings.build(:name => name) if setting.blank?
      setting.value = value
      # save only if parent has been saved. else we expect a parent.save call
      # which will cascade to the children since they were created with build()
      unless self.new_record?
        setting.save
        # reload collection so the read_setting() finds the settings with 'detect()'
        self.settings.reload
      end
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
      name = name.to_s
      raise ArgumentError.new("Setting name must not be blank") if name.blank?
      # default settings
      options[:type] ||= :string    # treat as string
      options[:default] ||= nil     # no default value
      has_setting_options[name] = options
      
      define_method("#{name}=".intern) do |value|
        value = value.nil? ? nil : value.to_s 
        write_setting(name, value)
      end
      
      # getter
      define_method(name) do |*args| 
        setting = read_setting(name)
        options = args.first || has_setting_options[name]
        return options[:default] if setting.nil? 
        
        case options[:type]
          when :string : setting.value
          when :int : setting.value.nil? ? nil : setting.value.to_i
          when :float : setting.value.nil? ? nil : setting.value.to_f
          else raise ArgumentError.new("Unsupported type: #{options[:type]}")
        end
      end
    end
  end
end