require_relative 'stepping_piece'

class King < SteppingPiece
  def move_directions
    MOVE_DIRECTIONS[:diagonals] + MOVE_DIRECTIONS[:axials]
  end
end