# frozen_string_literal: true

module Mastermind
  class Game
    # Defines the code breaker game mode
    class CodeBreaker
      attr_reader :code

      def initialize
        @code = Code.new
      end

      def take_turn(guess)
        print "\nEnter a four digit code with numbers 1-6 (eg. 1122): "
        until (selection = gets.chomp).match?(/^[1-6]{4}$/)
          print 'Invalid entry. Enter a four digit code with numbers 1-6 (eg. 1122): '
        end
        guess.make_guess(selection, code)
      end
    end
  end
end
