# frozen_string_literal: true

module Mastermind
  class Game
    # Defines the code maker game mode
    class CodeMaker
      attr_reader :code

      def initialize
        @code       = generate_code
        @code_set   = generate_code_set
        @guess_set  = @code_set.clone
        @next_guess = '1122'
      end

      def take_turn(guess)
        guess.make_guess(@next_guess, code)
        return if guess.victory?

        choose_next_guess(guess)
      end

      private

      def generate_code
        print 'Enter a four digit code with numbers 1-6 (eg. 1122): '
        until (selection = gets.chomp).match?(/^[1-6]{4}$/)
          print 'Invalid entry. Enter a four digit code with numbers 1-6 (eg. 1122): '
        end
        selection = selection.split('').map(&:to_i)
        Code.new(first: selection[0], second: selection[1], third: selection[2], fourth: selection[3])
      end

      def generate_code_set
        (1..6).to_a.repeated_permutation(4).map(&:join).each.with_object(Set.new) { |code, set| set << code }
      end

      def choose_next_guess(guess)
        @guess_set.delete(@next_guess)
        eliminate_wrong_codes(guess, @code_set)
        @next_guess = determine_best_guess(@guess_set, @code_set)
      end

      def eliminate_wrong_codes(guess, code_set)
        code_set.each { |code| code_set.delete(code) unless same_feedback?(guess, code) }
      end

      def same_feedback?(guess, code)
        guess.feedback.to_a == Guess.new.make_guess(guess.to_a.join, code.chars.map(&:to_i)).feedback.to_a
      end

      def determine_best_guess(guess_set, code_set)
        best_guess(get_guess_scores(guess_set, code_set), code_set)
      end

      def get_guess_scores(guess_set, code_set)
        guess_set.each.with_object(Hash.new { |h, k| h[k] = [] }) do |guess, hash|
          hash[get_feedback_scores(code_set, guess).values.max] << guess
        end
      end

      def get_feedback_scores(code_set, guess)
        code_set.each.with_object(Hash.new(0)) do |code, hash|
          hash[Guess.new.make_guess(guess, code.chars.map(&:to_i)).feedback.to_a] += 1
        end
      end

      def best_guess(scores, code_set)
        scores[scores.keys.min].each { |guess| return guess if code_set.include?(guess) }
        scores[scores.keys.min].first
      end
    end
  end
end
