require_relative 'stepping_piece'

class King < SlidingPiece
  def move_directions
    MOVE_DIRECTIONS[:diagonals] + MOVE_DIRECTIONS[:axials]
  end
end