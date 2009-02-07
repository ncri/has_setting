module HasSetting
  module Formatters
    @@formatters = {}
    #
    # register a formatter:
    #  * type: a Symbol that is used to identify this formatter in the has_setting options hash via the :type option
    #  * formatter: the formatter, an object which supports to_type and to_s methods
    def self.register_formatter(type, formatter)
      if !formatter.respond_to?(:to_s) || !formatter.respond_to?(:to_type)
        raise ArgumentError.new('Formatter does not support to_s/to_type')
      end
      @@formatters[type] = formatter
    end
    
    # Lookup a Formatter by type symbol
    # raises ArgumentError if the formatter is not found
    def self.for_type(type)
      formatter = @@formatters[type]
      raise ArgumentError.new("Can not find a formatter for #{type}") unless formatter
      formatter
    end    
    
    # Helper class which handles nil values
    class NilSafeFormatter
      # Converts the String from DB to the specified type
      # Nil is returned for nil values
      def to_type(value)
        safe_to_type(value) unless value == nil
      end
      # Converts the value to String for storing in DB
      # Nil is returned for nil values
      def to_s(value)
        safe_to_s(value) unless value == nil
      end
    end
    
    # Formatter for Strings
    class StringFormatter < NilSafeFormatter
      def to_type(value)
        value
      end
      def safe_to_s(value)
        value.to_s
      end
    end
    
    class IntsFormatter < NilSafeFormatter
      def safe_to_type(value)
        value.split(',').map() {|item| Formatters.for_type(:int).to_type(item)}
      end
      def safe_to_s(value)
        Array(value).map() {|item| Formatters.for_type(:int).to_s(item)}.join(',')
      end
    end
    
    class FloatsFormatter < NilSafeFormatter
      def safe_to_type(value)
        value.split(',').map() {|item| Formatters.for_type(:float).to_type(item)}
      end
      def safe_to_s(value)
        Array(value).map() {|item| Formatters.for_type(:float).to_s(item)}.join(',')
      end
    end
    
    class StringsFormatter < NilSafeFormatter
      def safe_to_type(value)
        # Ruby does not know "negative look before". Or i dont know how to do it in ruby. Thus
        # i ended up using some reverse calls... ugly. Anyone out there eager to help me out?
        value.reverse.split(/,(?!\\)/).map() {|item| item.reverse.gsub('\,', ',')}.reverse
      end
      def safe_to_s(value)
        # Escape the separator character ',' with a backslash
        Array(value).map() {|item| item.gsub(',', '\,')}.join(',')
      end
    end
    
    
    # Formatter for ints
    # Throws ArgumentError if value can not be converted
    class IntFormatter < NilSafeFormatter
      # Integer() does not treat "2.6" the same as 2.6
      # while 2.6 is a valid Intger() (-> 2), "2.6" is not.
      # Note that "2" is a valid argument for Integer() and that "".to_i is valid 
      # while Integer('') is not...
      # Circumvent this by first convert with Float() so everything obeys to the same rules
      def safe_to_type(value)
        Integer(Float(value))
      end
      def safe_to_s(value)
        Integer(Float(value)).to_s
      end
    end
    # Formatter for float values
    # Throws ArgumentError if value can not be converted
    class FloatFormatter < NilSafeFormatter
      def safe_to_type(value)
        Float(value)
      end
      def safe_to_s(value)
        Float(value).to_s
      end
    end
  end
end