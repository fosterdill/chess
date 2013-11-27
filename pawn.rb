require_relative 'piece'

class Pawn < Piece
  def initialize(position, color, board)
    super(position, color, board)
    @direction = (@color == :white ? 1 : -1)
    @rank = (@color == :white ? 1 : 6)
  end

  MOVE_DIRECTIONS = {
    :up => [
      [0, 1],
      [0, 2]
    ],

    :diagonals => [
      [1, 1],
      [-1, 1]
    ]
  }


  def moves
    moves = []

    MOVE_DIRECTIONS[:up].each do |direction|
      next if direction == [0, 2] && (self.position[1] <=> @rank) == @direction

      new_pos = [self.position[0]]
      new_pos += [self.position[1] + (@direction * direction[1])]

      unless on_piece?(new_pos)
        moves << new_pos unless direction == [0, 2] && moves.empty?
      end
    end

    MOVE_DIRECTIONS[:diagonals].each do |direction|

      new_pos = [self.position[0] + direction[0]]
      new_pos += [self.position[1] + (@direction * direction[1])]

      if on_piece?(new_pos) && !same_color?(new_pos)
        moves << new_pos
      end
    end

    moves
  end
end