# frozen_string_literal: true

module Mastermind
  class Game
    # Defines the secret code
    class Code
      def initialize(numbers = {})
        @first    = numbers[:first]  || rand(1..6)
        @second   = numbers[:second] || rand(1..6)
        @third    = numbers[:third]  || rand(1..6)
        @fourth   = numbers[:fourth] || rand(1..6)
        @revealed = false
      end

      def reveal
        @revealed = true
      end

      def to_a
        [@first, @second, @third, @fourth]
      end

      def to_s
        @revealed ? "[#{@first}][#{@second}][#{@third}][#{@fourth}]" : '[?][?][?][?]'
      end
    end
  end
end
