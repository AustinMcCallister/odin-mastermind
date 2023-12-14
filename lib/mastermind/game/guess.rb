# frozen_string_literal: true

module Mastermind
  class Game
    # Defines a guess
    class Guess
      attr_reader :feedback

      def initialize
        @first    = nil
        @second   = nil
        @third    = nil
        @fourth   = nil
        @feedback = Feedback.new
      end

      def make_guess(guess, code)
        @first, @second, @third, @fourth = guess.split('').map(&:to_i)
        @feedback.give_feedback(to_a, code.to_a)
        self
      end

      def victory?
        @feedback.victory?
      end

      def to_a
        [@first, @second, @third, @fourth]
      end

      def to_s
        @first && @second && @third && @fourth ? "[#{@first}][#{@second}][#{@third}][#{@fourth}]" : '[ ][ ][ ][ ]'
      end
    end
  end
end
