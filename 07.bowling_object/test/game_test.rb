# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    @perfect_game = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    @all_gutters_game = Game.new('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
  end
  def test_frames
    assert_equal [[6, 3], [9, 0], [0, 3], [8, 2], [7, 3], [10], [9, 1], [8, 0], [10], [6, 4, 5]], @game.frames
    assert_equal [[10], [10], [10], [10], [10], [10], [10], [10], [10], [10, 10, 10]], @perfect_game.frames
    assert_equal [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]], @all_gutters_game.frames
  end

  def test_score
    assert_equal 139, @game.score
    assert_equal 300, @perfect_game.score
    assert_equal 0, @all_gutters_game.score
  end
end
