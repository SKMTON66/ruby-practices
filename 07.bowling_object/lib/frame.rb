# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :shots, :first_shot, :second_shot

  def initialize(shots)
    @shots = shots
    @first_shot = shots[0]
    @second_shot = shots[1]
  end

  def score
    shots.map(&:score).sum
  end

  def strike?
    first_shot.strike?
  end

  def spare?
    !strike? && first_shot.score + second_shot.score == 10
  end
end
