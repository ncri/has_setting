class Bar < ActiveRecord::Base
  has_setting(:setting_1)
  has_setting(:setting_2, :type => :int)
end