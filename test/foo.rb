class Foo < ActiveRecord::Base
  has_setting(:setting_1)
  has_setting(:setting_2, :type => :float)
  has_setting(:with_default, :default => 'def')
end