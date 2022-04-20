require_relative '../test_helper'

class HasSettingTest < Test::Unit::TestCase
  def setup
    @foo = Foo.create!
    @bar = Bar.create!
    @baz = Baz.create!
  end


  def test_setting_has_accessors
    assert @foo.respond_to?(:setting_1)
    assert @foo.respond_to?(:setting_1=)
  end

  def test_settings_are_destroyed
    count_before = HasSetting::Setting.count
    @foo.setting_1 = 10
    @foo.save!
    assert_equal(count_before + 1, HasSetting::Setting.count)
    @foo.destroy
    assert_equal(count_before, HasSetting::Setting.count)

  end

  def test_write_setting
    count_before = HasSetting::Setting.count
    @foo.write_setting('name', 'value1')
    @foo.save!
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
    @foo.save!
    assert_equal(count_before + 1, HasSetting::Setting.count)
    assert_equal('bli', @foo.setting_1)
    @foo.setting_1 = 'bla'
    assert_equal('bla', @foo.setting_1)
  end

  def test_different_classes_do_not_share_setting
    count_before = HasSetting::Setting.count
    @foo.setting_1 = 'foo'
    @foo.save!
    @bar.setting_1 = 'bar'
    @bar.save!
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

  def test_default_values
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

  def test_not_everyone_has_settings_association
    assert_equal(true, @foo.respond_to?(:settings))
    assert_equal(true, @bar.respond_to?(:settings))
    assert_equal(false, @baz.respond_to?(:settings))
  end


  def test_boolean_setting_without_default
    assert_equal nil, @foo.setting_3
    @foo.setting_3 = true
    @foo.save!

    @foo = Foo.find @foo.id
    assert_equal true, @foo.setting_3
  end

  def test_boolean_setting_with_default
    assert_equal false, @foo.setting_4
    @foo.setting_4 = true
    @foo.save!
    @foo = Foo.find @foo.id
    assert_equal true, @foo.setting_4
  end

  def test_boolean_setting_with_default_and_no_saving
    assert_equal false, @foo.setting_4
    @foo.setting_4 = true
    assert_equal true, @foo.setting_4
    @foo.setting_4 = nil
    assert_equal nil, @foo.setting_4
    @foo.setting_4 = false
    assert_equal false, @foo.setting_4
  end

  def test_proc_value_as_default_value
    assert_equal @foo.setting_5, true
  end

  def test_locale_awareness
    I18n.locale = :de
    @bar.setting_1 = 'setting de'
    I18n.locale = 'de-CH'
    @bar.setting_1 = 'setting ch'
    assert_equal 'setting ch', @bar.setting_1
    I18n.locale = :de
    assert_equal 'setting de', @bar.setting_1
  end


end