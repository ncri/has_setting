require 'rubygems'
require 'active_record'
require 'test/unit'

require File.dirname(__FILE__) + '/../lib/has_setting'

I18n.available_locales = %w(en de de-CH)

ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'test.sqlite3',
  :timeout => 5000
)

ActiveRecord::Base.connection.drop_table(:settings) rescue ActiveRecord::StatementInvalid
[:foos, :bars, :bazs].each do |table|
  ActiveRecord::Base.connection.drop_table(table) rescue ActiveRecord::StatementInvalid
end



ActiveRecord::Base.connection.create_table(:settings) do |table|
  table.string(:value,      :limit => 255)
  table.string(:name,       :limit => 64,     :null => false)
  table.string(:owner_type, :limit => 255,    :null => false)
  table.integer(:owner_id,                    :null => false)
  table.string(:locale)
end
[:foos, :bars, :bazs].each do |table|
  ActiveRecord::Base.connection.create_table(table) do |t|
  end
end

require File.join(File.dirname(__FILE__), 'foo')
require File.join(File.dirname(__FILE__), 'bar')
require File.join(File.dirname(__FILE__), 'baz')