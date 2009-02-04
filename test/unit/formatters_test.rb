require File.dirname(__FILE__) + '/../test_helper'
include HasSetting
class FormattersTest < Test::Unit::TestCase
  def test_for_type
    [:string, :float, :int].each do |symbol|
      assert(Formatters.for_type(symbol), "No formatter for #{symbol}")
    end
    assert_raises(ArgumentError) do
      Formatters.for_type(:rarararararara_i_do_not_exist)
    end
  end
  
  def test_string_formatter()
    f = Formatters::StringFormatter.new
    assert_equal('', f.to_s(''))
    assert_equal('a', f.to_s('a'))
    assert_equal('', f.to_type(''))
    assert_equal('a', f.to_type('a'))
  end
  
  def test_int_formatter()
    f = Formatters::IntFormatter.new
    assert_raises(ArgumentError) do 
      f.to_s('')
    end
    assert_raises(ArgumentError) do 
      f.to_s('asas')
    end
    assert_nil(f.to_s(nil))
    assert_equal('2', f.to_s(2.6))
    assert_equal('2', f.to_s(2))
    
    assert_raises(ArgumentError) do 
      f.to_type('')
    end
    assert_raises(ArgumentError) do 
      f.to_type('asas')
    end
    assert_nil(f.to_type(nil))
    assert_equal(2, f.to_type('2'))
    assert_equal(2, f.to_type('2.6'))
  end  
  
  def test_float_formatter()
    f = Formatters::FloatFormatter.new
    assert_raises(ArgumentError) do 
      f.to_s('')
    end
    assert_raises(ArgumentError) do 
      f.to_s('asas')
    end
    assert_nil(f.to_s(nil))
    assert_equal('2.6', f.to_s(2.6))
    assert_equal('2.0', f.to_s(2))
    
    assert_raises(ArgumentError) do 
      f.to_type('')
    end
    assert_raises(ArgumentError) do 
      f.to_type('asas')
    end
    assert_nil(f.to_type(nil))
    assert_equal(2.0, f.to_type('2'))
    assert_equal(2.6, f.to_type('2.6'))
  end  
end