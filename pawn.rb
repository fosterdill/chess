require_relative 'piece'
class Pawn < Piece
  attr_writer :moved
  def initialize(position, color, board)
    super(position, color, board)
    @moved = false
    @direction = (@color == :white ? 1 : -1)
  end

  MOVE_DIRECTIONS = [
    [0, 1],
    [1, 1],
    [-1, 1]
  ]

  def moves
    moves = []

    if(moved?)

    else
      MOVE_DIRECTIONS << [0, 2]

      MOVE_DIRECTIONS.pop
      self.moved = true
    end
  end

  def moved?
    @moved
  end
end