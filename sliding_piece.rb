require_relative 'piece'
class SlidingPiece < Piece

  MOVE_DIRECTIONS = {
    :axials => [
      [0, 1],
      [1, 0],
      [0, -1],
      [-1, 0]
    ],

    :diagonals => [
      [1, 1],
      [-1, 1],
      [1, -1],
      [-1, -1]
    ]
  }

  def moves

  end
end