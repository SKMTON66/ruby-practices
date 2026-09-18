# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'

class FrameTest < Minitest::Test
  def setup
    @strike_frame = Frame.new([Shot.new('X')])
    @spare_frame = Frame.new([Shot.new('3'), Shot.new('7')])
    @open_frame = Frame.new([Shot.new('3'), Shot.new('3')])
  end

  def test_shots
    assert_equal [10], @strike_frame.shots
    assert_equal [3, 7], @spare_frame.shots
    assert_equal [3, 3], @open_frame.shots
  end

  def test_score
    assert_equal 10, @strike_frame.score
    assert_equal 10, @spare_frame.score
    assert_equal 6, @open_frame.score
  end

  def test_spare
    assert @spare_frame.spare?
    refute @strike_frame.spare?
    refute @open_frame.spare?
  end
end
