# frozen_string_literal: true

module Mastermind
  # Defines a game of Mastermind
  class Game
    def initialize
      @game_type = choose_type
      @guesses   = Array.new(12) { Guess.new }
      @winner    = nil
      game_loop
    end

    private

    def choose_type
      print 'Would you like to be the codemaker? (y/N): '
      until (selection = gets.chomp) && selection.match?(/^[nyNY]?$/)
        print 'Invalid choice. Would you like to be the codemaker? (y/N): '
      end
      selection.match?(/^[yY]$/) ? CodeMaker.new : CodeBreaker.new
    end

    def game_loop
      @guesses.each do |guess|
        break if @winner

        draw_game_board
        @game_type.take_turn(guess)
        victory?(guess)
      end
      wrap_up
    end

    def draw_game_board
      DisplayController.clear_terminal
      DisplayController.draw_board(@guesses)
      DisplayController.draw_scoreboard(@game_type.code)
    end

    def victory?(guess)
      @winner = guess.victory?
    end

    def wrap_up
      @game_type.code.reveal
      draw_game_board
      print "\nGame over! Would you like to play again? (y/N): "
      until (selection = gets.chomp) && selection.match?(/^[nyNY]?$/)
        print 'Invalid choice. Would you like to play again? (y/N): '
      end
      return unless selection.match?(/^[yY]$/)

      reset_board
      game_loop
    end

    def reset_board
      @game_type = choose_type
      @guesses   = Array.new(12) { Guess.new }
      @winner    = nil
    end
  end
end
