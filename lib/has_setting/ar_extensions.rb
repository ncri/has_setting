module HasSetting

  extend ActiveSupport::Concern

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
              setting.save if setting.changed?
            end
          end
        end
      end

      raise ArgumentError.new("Setting #{name }is already defined on #{self.name}") if self.has_setting_options.has_key?(name)

      # default options
      type = options[:type] || :string    # treat as string
      options[:localize] ||= false
      options[:no_fallback] ||= false
      self.has_setting_options[name] = options

      # setter
      define_method("#{name}=".intern) do |value|
        formatter = HasSetting::Formatters.for_type(type)
        write_setting(name, formatter.to_s(value))
      end

      # getter
      define_method(name) do |*args|
        setting = read_setting(name)
        options = args.first || has_setting_option(name)
        if setting.nil?
          result =
            if options[:default].is_a?(Proc)
              instance_exec(&options[:default])
            else
              options[:default]
            end
          return result
        end
        formatter = Formatters.for_type(options[:type] || type)
        formatter.to_type(setting.value)
      end
    end
  end

  def write_setting(name, value)
    # find an existing setting or build a new one
    locale = localize?(name) ? I18n.locale : nil
    setting = self.settings.detect() {|item| item.name == name and item.locale.to_s == locale.to_s }
    setting = self.settings.build(:name => name, locale: locale) if setting.blank?
    setting.value = value
    # mark model as changed to make sure model is saved so that after_save is triggered even if only settings change
    # maybe there is a better way of doing this.
    self.updated_at = Time.now if self.respond_to?(:updated_at)
  end

  def read_setting(name)
    # use detect instead of SQL find. like this the 'cached' has_many-collection is inited
    # only once
    locale = localize?(name) ? I18n.locale.to_s : ""
    s = self.settings.detect() {|item| item.name == name and item.locale.to_s == locale} # first see if there is a setting with current locale
    s ||= self.settings.detect() {|item| item.name == name} unless no_fallback?(name) # then if not found, take the first setting with matching name (TODO: add locale fallbacks)
    s
  end

  def localize? name
    options = has_setting_option name
    options ? options[:localize] : false
  end

  def no_fallback? name
    options = has_setting_option name
    options ? options[:no_fallback] : false
  end

  def has_setting_option name
    klass = self.class
    option = klass.has_setting_options ? klass.has_setting_options[name] : nil
    while option.nil? and
          klass.superclass != ActiveRecord::Base
      klass = klass.superclass
      if klass.respond_to?(:has_setting_options) and klass.has_setting_options
        option = klass.has_setting_options[name]
      end
    end
    option
  end

end
