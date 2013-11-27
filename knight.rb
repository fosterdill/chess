require_relative 'stepping_piece'

class Knight < SteppingPiece
  def move_directions
    [ [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2],
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1] ]
  end
end