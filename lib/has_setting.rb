# Intialize the gem by including some extension to ActiveRecord::Base
require File.dirname(__FILE__) + '/has_setting/ar_extensions'
require File.dirname(__FILE__) + '/has_setting/formatters'
require File.dirname(__FILE__) + '/has_setting/setting'
ActiveRecord::Base.class_eval do
  include(HasSetting::InstanceMethods)
  extend(HasSetting::ClassMethods)
end


HasSetting::Formatters.register_formatter(:string, HasSetting::Formatters::StringFormatter.new)
HasSetting::Formatters.register_formatter(:strings, HasSetting::Formatters::StringsFormatter.new)
HasSetting::Formatters.register_formatter(:float, HasSetting::Formatters::FloatFormatter.new)
HasSetting::Formatters.register_formatter(:floats, HasSetting::Formatters::FloatFormatter.new)
HasSetting::Formatters.register_formatter(:int, HasSetting::Formatters::IntFormatter.new)
HasSetting::Formatters.register_formatter(:ints, HasSetting::Formatters::IntsFormatter.new)
