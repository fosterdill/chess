require_relative 'sliding_piece'

class Queen < SlidingPiece
  def move_directions
    MOVE_DIRECTIONS[:diagonals] + MOVE_DIRECTIONS[:axials]
  end
end