  # frozen_string_literal: true

  require 'minitest/autorun'
  require_relative '../lib/shot'

  class ShotTest < Minitest::Test
    def setup
      @shot = Shot.new('9')
      @strike_shot = Shot.new('X')
    end

    def test_shot_score
      assert_equal 9, @shot.score
      assert_equal 10, @strike_shot.score
    end

    def test_strike
      assert @strike_shot.strike?
      refute @shot.strike?
    end
  end
