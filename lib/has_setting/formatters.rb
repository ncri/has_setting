module HasSetting
  module Formatters
    @@formatters = {}
    
    def self.register_formatter(symbol, formatter)
      if !formatter.respond_to?(:to_s) || !formatter.respond_to?(:to_type)
        raise ArgumentError.new('Formatter does not support to_s/to_type')
      end
      @@formatters[symbol] = formatter
    end
    
    def self.for_type(symbol)
      formatter = @@formatters[symbol]
      raise ArgumentError.new("Can not find a formatter for #{symbol}") unless formatter
      formatter
    end    
    
    class NilSafeFormatter
      def to_type(value)
        safe_to_type(value) unless value == nil
      end
      
      def to_s(value)
        safe_to_s(value) unless value == nil
      end
    end
    class StringFormatter
      def to_type(value)
        value
      end
      def to_s(value)
        value
      end
    end
    
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