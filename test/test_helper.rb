require 'rubygems'
require 'active_record'
require 'test/unit'

require File.dirname(__FILE__) + '/../lib/has_setting'


ActiveRecord::Base.establish_connection(  
  :adapter  => 'sqlite3',   
  :database => 'test.sqlite3',   
  :timeout => 5000
)

ActiveRecord::Base.connection.drop_table(:settings) rescue ActiveRecord::StatementInvalid
ActiveRecord::Base.connection.drop_table(:foos) rescue ActiveRecord::StatementInvalid
ActiveRecord::Base.connection.drop_table(:bars) rescue ActiveRecord::StatementInvalid



ActiveRecord::Base.connection.create_table(:settings) do |table|
  table.string(:value,      :limit => 255)
  table.string(:name,       :limit => 64,     :null => false)
  table.string(:owner_type, :limit => 255,    :null => false)
  table.integer(:owner_id,                    :null => false)
end
ActiveRecord::Base.connection.create_table(:foos) do |table|
end
ActiveRecord::Base.connection.create_table(:bars) do |table|
end

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = Logger::DEBUG # change to DEBUG if you want to see something :-)

require File.join(File.dirname(__FILE__), 'foo')
require File.join(File.dirname(__FILE__), 'bar')