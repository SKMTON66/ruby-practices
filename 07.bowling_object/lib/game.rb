# frozen_string_literal: true

require_relative 'shot'
require_relative 'frame'

class Game
  LAST_FRAME_INDEX = 9
  NINTH_FRAME_INDEX = 8

  attr_reader :score

  def initialize(marks)
    @shot_objects = marks.split(',').map { |mark| Shot.new(mark) }
    @frames = create_frames
    @score = calc_game_score
  end

  def frames
    @frames.map(&:shots)
  end

  private

  def create_frames
    shots = []
    frames = []

    @shot_objects.each do |shot_object|
      shots << shot_object
      if (frames.length < LAST_FRAME_INDEX) && (shot_object.strike? || shots.length == 2)
        frames << Frame.new(shots)
        shots = []
      end
    end
    frames << Frame.new(shots)
    frames
  end

  def calc_game_score
    game_score = 0
    @frames.each_with_index do |frame, index|
      game_score += frame.score
      next if index == LAST_FRAME_INDEX
      game_score += if frame.spare?
                      @frames[index + 1].first_shot.score
                    elsif frame.strike?
                      strike_bonus(index)
                    else
                      0
                    end
    end
    game_score
  end

  def strike_bonus(index)
    next_frame = @frames[index + 1]
    second_next_frame = @frames[index + 2]
    if next_frame.strike? && index != NINTH_FRAME_INDEX
      next_frame.score + second_next_frame.first_shot.score
    else
      next_frame.first_shot.score + next_frame.second_shot.score
    end
  end
end
