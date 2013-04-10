# Intialize the gem by including some extension to ActiveRecord::Base
require File.dirname(__FILE__) + '/has_setting/ar_extensions'
require File.dirname(__FILE__) + '/has_setting/formatters'
require File.dirname(__FILE__) + '/has_setting/setting'


ActiveSupport.on_load(:active_record) do
  include HasSetting
end


HasSetting::Formatters.register_formatter(:string, HasSetting::Formatters::StringFormatter.new)
HasSetting::Formatters.register_formatter(:strings, HasSetting::Formatters::StringsFormatter.new)
HasSetting::Formatters.register_formatter(:float, HasSetting::Formatters::FloatFormatter.new)
HasSetting::Formatters.register_formatter(:floats, HasSetting::Formatters::FloatsFormatter.new)
HasSetting::Formatters.register_formatter(:int, HasSetting::Formatters::IntFormatter.new)
HasSetting::Formatters.register_formatter(:ints, HasSetting::Formatters::IntsFormatter.new)
HasSetting::Formatters.register_formatter(:boolean, HasSetting::Formatters::BooleanFormatter.new)
HasSetting::Formatters.register_formatter(:booleans, HasSetting::Formatters::BooleansFormatter.new)
HasSetting::Formatters.register_formatter(:strict_boolean, HasSetting::Formatters::StrictBooleanFormatter.new)
HasSetting::Formatters.register_formatter(:strict_booleans, HasSetting::Formatters::StrictBooleansFormatter.new)