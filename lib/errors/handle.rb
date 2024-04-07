module Handle
  # this module will handle errors in a class by adding 
  # 
  # prepend Handler
  # Handler.error_from :some_method_name
  #
  def self.errors_from(method)
    define_method(method) do |*args|
      begin
        super(*args)
      rescue 
      rescue PlayerError => e
        puts "Rescued:\n\n" \
             " - Method: #{self.class.name}##{method}\n" \
             " - Arguments: #{args}\n" \
             " - Error Message: #{e.message}\n" \
             " - ErrorClass: #{e.class}"
      end
    end
  end

  module Error
    class ReelWordsError < StandardError
      def initialize(message, state = true)
        super(message)
        @state = state
      end
      attr_reader :state
    end

    class GameError < ReelWordsError
      def initialize(message)
        super(message)
      end
    end

    class PlayerError < ReelWordsError
      def initialize(message)
        super(message)
      end
    end
  end
end
