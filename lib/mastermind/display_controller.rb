# frozen_string_literal: true

module Mastermind
  # Controls the display of the game elements
  module DisplayController
    def self.draw_board(guesses)
      puts '┌────────────┬────┐'
      guesses.each.with_index do |guess, index|
        puts "│#{guess}│#{guess.feedback}│"
        puts '├────────────┼────┤' unless index == (guesses.size - 1)
      end
      puts '└────────────┴────┘'
    end

    def self.draw_scoreboard(code)
      puts '┌────────────┐'
      puts "│#{code}│"
      puts '└────────────┘'
    end

    def self.clear_terminal
      system('clear') || system('cls')
    end
  end
end
