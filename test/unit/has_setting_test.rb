require File.dirname(__FILE__) + '/../test_helper'

class HasSettingTest < Test::Unit::TestCase
  def setup()
    @foo = Foo.create!
    @bar = Bar.create!
  end
  
  def test_setting_has_accessor
    assert @foo.respond_to?(:setting_1)
    assert @foo.respond_to?(:setting_1=)
  end
  
  
  def test_has_many
    assert @foo.respond_to?(:settings)
    assert @foo.settings.is_a?(Array)
  end
  
  
  def test_write_setting
    count_before = HasSetting::Setting.count
    @foo.write_setting('name', 'value1')
    assert_equal(count_before + 1, HasSetting::Setting.count)
    setting = @foo.read_setting('name')
    assert setting
    assert_equal('value1', setting.value)
    
    @foo.write_setting('name', 'value2')
    assert_equal(count_before + 1, HasSetting::Setting.count) 
    setting = @foo.read_setting('name')
    assert setting
    assert_equal('value2', setting.value)
  end
  
  def test_setting_accessors
    count_before = HasSetting::Setting.count
    assert(!@foo.setting_1)
    @foo.setting_1 = 'bli'
    assert_equal(count_before + 1, HasSetting::Setting.count)
    assert_equal('bli', @foo.setting_1)
    @foo.setting_1 = 'bla'
    assert_equal('bla', @foo.setting_1)
  end
  
  def test_different_classes_do_not_share_setting
    count_before = HasSetting::Setting.count
    @foo.setting_1 = 'foo'
    @bar.setting_1 = 'bar'
    assert_equal(count_before + 2, HasSetting::Setting.count)
    
    assert_equal('foo', @foo.setting_1)
    assert_equal('bar', @bar.setting_1)
  end
  
  def test_has_nil_setting
    @foo.setting_1 = nil
    assert(@foo.read_setting('setting_1'))
    assert(!@foo.setting_1)
  end
  
  def test_options_on_getter
    @foo.setting_1 = '12.3'
    assert_equal('12.3', @foo.setting_1)
    assert_equal(12, @foo.setting_1(:type => :int))
    assert_equal(12.3, @foo.setting_1(:type => :float))
    
    # Foo.setting_2 is a float setting. Override and get as string
    @foo.setting_2 = 12.3
    assert_equal('12.3', @foo.setting_2(:type => :string))
  end
  
  def test_different_classes_do_not_share_options()
    @foo.setting_2 = 12.3
    assert_equal(12.3, @foo.setting_2)
    @bar.setting_2 = 12.3
    assert_equal(12, @bar.setting_2)
  end
  
  def test_default_values()
    assert_equal('def', @foo.with_default)
    assert_equal('override def', @foo.with_default(:default => 'override def'))
    @foo.with_default = 'not def'
    assert_equal('not def', @foo.with_default)
  end
  
  def test_write_settings_without_saved_parent
    my_foo = Foo.new
    count_before = HasSetting::Setting.count
    my_foo.with_default = 'radabumm'
    assert_equal(count_before, HasSetting::Setting.count)
    assert_equal('radabumm', my_foo.with_default)
    my_foo.save!
    assert_equal(count_before + 1, HasSetting::Setting.count)
    assert_equal('radabumm', my_foo.with_default)
  end
  
end