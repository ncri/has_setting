require File.dirname(__FILE__) + '/../test_helper'
include HasSetting
class FormattersTest < Test::Unit::TestCase
  # def test_for_type
  #   [:string, :float, :floats, :int, :ints, :strings, :boolean, :booleans, :strict_boolean, :strict_booleans].each do |symbol|
  #     assert(Formatters.for_type(symbol), "No formatter for #{symbol}")
  #     if symbol == :strict_boolean
  #       assert_equal(Formatters.for_type(symbol).class.to_s, "HasSetting::Formatters::StrictBooleanFormatter")
  #     elsif symbol == :strict_booleans
  #       assert_equal(Formatters.for_type(symbol).class.to_s, "HasSetting::Formatters::StrictBooleansFormatter")
  #     else
  #       assert_equal(Formatters.for_type(symbol).class.to_s, "HasSetting::Formatters::#{symbol.to_s.capitalize}Formatter")
  #     end
  #   end
  #   assert_raises(ArgumentError) do
  #     Formatters.for_type(:rarararararara_i_do_not_exist)
  #   end
  # end
  
  # def test_strings_formatter
  #   f = Formatters::StringsFormatter.new
  #   assert_equal(nil, f.to_s(nil))
  #   assert_equal('bla', f.to_s('bla'))
  #   assert_equal('bla', f.to_s(['bla']))
  #   assert_equal('bla,bli', f.to_s(['bla', 'bli']))
  #   assert_equal('\,schni\,schna\,,bli,\,bla', f.to_s([',schni,schna,', 'bli', ',bla']))
  #   assert_equal('\,\,\,\,,\,\,\,,\,\,,\,', f.to_s([',,,,', ',,,', ',,', ',']))
    
  #   assert_equal(nil, f.to_type(nil))
  #   assert_equal([], f.to_type(''))
  #   assert_equal(['bli'], f.to_type('bli'))
  #   assert_equal(['bli','', 'bla'], f.to_type('bli,,bla'))
  #   assert_equal([',schni,schna,', 'bli', ',bla'], f.to_type('\,schni\,schna\,,bli,\,bla'))
  #   assert_equal([',,,,', ',,,', ',,', ','], f.to_type('\,\,\,\,,\,\,\,,\,\,,\,'))
  # end
  

  # def test_string_formatter()
  #   f = Formatters::StringFormatter.new
  #   assert_equal('', f.to_s(''))
  #   assert_equal('a', f.to_s('a'))
  #   assert_equal('', f.to_type(''))
  #   assert_equal('a', f.to_type('a'))
  # end
  
  # def test_boolean_formatter
  #   f = Formatters::BooleanFormatter.new
  #   assert_equal('0', f.to_s(''))
  #   assert_equal('1', f.to_s(true))
  #   assert_equal('0', f.to_s(false))
  #   assert_equal('0', f.to_s('0'))
  #   assert_equal('0', f.to_s(0))
  #   assert_equal('0', f.to_s(''))
  #   assert_equal(nil, f.to_s(nil))
    
  #   assert_equal(true, f.to_type('1'))
  #   assert_equal(false, f.to_type('0'))
  #   assert_equal(nil, f.to_type(nil))
  # end
  
  # def test_strict_boolean_formatter
  #   f = Formatters::StrictBooleanFormatter.new
  #   assert_equal('1', f.to_s(''))
  #   assert_equal('1', f.to_s(true))
  #   assert_equal('0', f.to_s(false))
  #   assert_equal('1', f.to_s('0'))
  #   assert_equal(nil, f.to_s(nil))
    
  #   assert_equal(true, f.to_type('1'))
  #   assert_equal(false, f.to_type('0'))
  #   assert_equal(nil, f.to_type(nil))
  # end
  # def test_int_formatter()
  #   f = Formatters::IntFormatter.new
  #   assert_raises(ArgumentError) do 
  #     f.to_s('')
  #   end
  #   assert_raises(ArgumentError) do 
  #     f.to_s('asas')
  #   end
  #   assert_nil(f.to_s(nil))
  #   assert_equal('2', f.to_s(2.6))
  #   assert_equal('2', f.to_s(2))
    
  #   assert_raises(ArgumentError) do 
  #     f.to_type('')
  #   end
  #   assert_raises(ArgumentError) do 
  #     f.to_type('asas')
  #   end
  #   assert_nil(f.to_type(nil))
  #   assert_equal(2, f.to_type('2'))
  #   assert_equal(2, f.to_type('2.6'))
  #   assert_equal(2, f.to_type(' 2.6 '))
  # end  
  
  # def test_float_formatter()
  #   f = Formatters::FloatFormatter.new
  #   assert_raises(ArgumentError) do 
  #     f.to_s('')
  #   end
  #   assert_raises(ArgumentError) do 
  #     f.to_s('asas')
  #   end
  #   assert_nil(f.to_s(nil))
  #   assert_equal('2.6', f.to_s(2.6))
  #   assert_equal('2.0', f.to_s(2))
    
  #   assert_raises(ArgumentError) do 
  #     f.to_type('')
  #   end
  #   assert_raises(ArgumentError) do 
  #     f.to_type('asas')
  #   end
  #   assert_nil(f.to_type(nil))
  #   assert_equal(2.0, f.to_type('2'))
  #   assert_equal(2.6, f.to_type('2.6'))
  # end  
  
  # def test_ints_formatter
  #   f = Formatters::IntsFormatter.new
  #   assert_equal(nil, f.to_s(nil))
  #   assert_equal('1', f.to_s(1))
  #   assert_equal('1', f.to_s([1]))
  #   assert_equal('1,2', f.to_s([1,2]))
    
  #   assert_equal(nil, f.to_type(nil))
  #   assert_equal([], f.to_type(''))
  #   assert_equal([1], f.to_type('1'))
  #   assert_equal([1,2], f.to_type('1,2'))
  # end
  # def test_floats_formatter
  #   f = Formatters::FloatsFormatter.new
  #   assert_equal(nil, f.to_s(nil))
  #   assert_equal('1.2', f.to_s(1.2))
  #   assert_equal('1.2', f.to_s([1.2]))
  #   assert_equal('1.2,1.3', f.to_s([1.2,1.3]))
    
  #   assert_equal(nil, f.to_type(nil))
  #   assert_equal([], f.to_type(''))
  #   assert_equal([1.2], f.to_type('1.2'))
  #   assert_equal([1.2,1.3], f.to_type('1.2,1.3'))
  #   assert_equal([1.2,1.3], f.to_type('1.2, 1.3'))
  # end
  # def test_booleans_formatter
  #   f = Formatters::BooleansFormatter.new
  #   assert_equal(nil, f.to_s(nil))
  #   assert_equal('1', f.to_s(true))
  #   assert_equal('1', f.to_s([true]))
  #   assert_equal('1,0', f.to_s([true,false]))
  #   assert_equal('0,0,0,0,', f.to_s(['', 0, false, '0', nil]))
    
  #   assert_equal(nil, f.to_type(nil))
  #   assert_equal([], f.to_type(''))
  #   assert_equal([true], f.to_type('1'))
  #   assert_equal([true, false], f.to_type('1,0'))
    
    
  #   # test boolean with values != true|false
  #   assert_equal('1', f.to_s('true'))
  #   assert_equal('1', f.to_s(555))
  # end
  
  
  # def test_strict_booleans_formatter
  #   f = Formatters::StrictBooleansFormatter.new
  #   assert_equal(nil, f.to_s(nil))
  #   assert_equal('1', f.to_s(true))
  #   assert_equal('1', f.to_s([true]))
  #   assert_equal('1,0', f.to_s([true,false]))
  #   assert_equal('1,1', f.to_s([1,0]))
    
  #   assert_equal(nil, f.to_type(nil))
  #   assert_equal([], f.to_type(''))
  #   assert_equal([true], f.to_type('1'))
  #   assert_equal([true, false], f.to_type('1,0'))
    
    
  #   # test boolean with values != true|false
  #   assert_equal('1', f.to_s('true'))
  #   assert_equal('1', f.to_s(555))
  # end
end