class Bar < ActiveRecord::Base
  has_setting(:setting_1, localize: true)
  has_setting(:setting_2, :type => :int)
end