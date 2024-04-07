module Errors
  class ReelWordsError < StandardError
    def initialize(message, state)
      super(message)
      @state = state
    end
    attr_reader :state
  end

  class GameError < ReelWordsError; end
  class PlayerError < ReelWordsError; end
end
