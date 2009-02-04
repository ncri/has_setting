Gem::Specification.new do |s|
  s.name = %q{has_setting}
  s.version = "0.3.2"
  s.date = %q{Feb. 4, 2009}
  s.authors = ["Simplificator GmbH"]
  s.email = %q{info@simplificator.com}
  s.summary = %q{Basic Setting/Properties for ActiveRecord models}
  s.homepage = %q{http://simplificator.com/en/lab}
  s.description = %q{Stores settings as key/value pairs in a settings table and provides accessors for them on the owning object}
  s.files = 
    ['lib/has_setting.rb', 'lib/has_setting/ar_extensions.rb', 
     'lib/has_setting/setting.rb', 
     'test/bar.rb', 'test/foo.rb', 'test/baz.rb', 'test/test_helper.rb', 'test/unit/has_setting_test.rb',
     'README']
end
