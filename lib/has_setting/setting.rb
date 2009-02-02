# ActiveRecord model to store key/value pairs (though the
# columns are called name/value to avoid upsetting a Database for using a 
# keyword as column name)
#
class HasSetting::Setting < ActiveRecord::Base
  belongs_to(:owner, :polymorphic => true)  
end