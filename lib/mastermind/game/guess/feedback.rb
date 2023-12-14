# frozen_string_literal: true

module Mastermind
  class Game
    class Guess
      # Defines feedback for a guess
      class Feedback
        def initialize
          @correct        = 0
          @correct_number = 0
        end

        def give_feedback(guess, code)
          check_correct(guess, code)
          check_correct_number(guess, code)
        end

        def victory?
          @correct == 4
        end

        def to_a
          [@correct, @correct_number]
        end

        def to_s
          feedback = []
          @correct.times { feedback << "\e[31m●\e[0m" }
          @correct_number.times { feedback << '●' }
          (4 - feedback.size).times { feedback << '○' }
          feedback.join
        end

        private

        def check_correct(guess, code)
          guess.each.with_index do |digit, index|
            next unless digit == code[index]

            @correct    += 1
            guess[index] = 0
            code[index]  = 0
          end
        end

        def check_correct_number(guess, code)
          guess.each.with_index do |digit, index|
            next unless digit != 0 && code.include?(digit)

            @correct_number             += 1
            guess[index]                 = 0
            code[code.find_index(digit)] = 0
          end
        end
      end
    end
  end
end
