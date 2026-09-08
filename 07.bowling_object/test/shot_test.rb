  # frozen_string_literal: true

  require 'minitest/autorun'
  require_relative '../lib/shot'

  class ShotTest < Minitest::Test
    def setup
      @shot = Shot.new('9')
      @strike_shot = Shot.new('X')
    end

    def test_mark
      assert_equal '9', @shot.mark
      assert_equal 'X', @strike_shot.mark
    end

    def test_shot_score
      assert_equal 9, @shot.score
      assert_equal 10, @strike_shot.score
    end
  end
