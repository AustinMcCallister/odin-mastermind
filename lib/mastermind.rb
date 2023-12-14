# frozen_string_literal: true

require './lib/mastermind/display_controller'
require './lib/mastermind/game'
require './lib/mastermind/game/code'
require './lib/mastermind/game/code_breaker'
require './lib/mastermind/game/code_maker'
require './lib/mastermind/game/guess'
require './lib/mastermind/game/guess/feedback'

# Mastermind project for the Ruby module through The Odin Project
module Mastermind
  Game.new
end
