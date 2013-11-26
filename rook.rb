require_relative 'sliding_piece'

class Rook < SlidingPiece
  def move_directions
    MOVE_DIRECTIONS[:axials]
  end
end