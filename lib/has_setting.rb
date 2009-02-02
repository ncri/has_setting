# Intialises the gem by including some extension to ActiveRecord::Base
require File.dirname(__FILE__) + '/has_setting/ar_extensions'
require File.dirname(__FILE__) + '/has_setting/setting'
ActiveRecord::Base.class_eval do
  include(HasSetting::InstanceMethods)
  extend(HasSetting::ClassMethods)
end