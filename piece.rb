class Piece
  attr_accessor :position, :board
  attr_reader :color

  SYMBOLS = {
    :white => {
      :King => "\u265A",
      :Queen => "\u265B",
      :Rook => "\u265C",
      :Bishop => "\u265D",
      :Knight => "\u265E",
      :Pawn => "\u265F"
    },
    :black => {
      :King => "\u2654",
      :Queen => "\u2655",
      :Rook => "\u2656",
      :Bishop => "\u2657",
      :Knight => "\u2658",
      :Pawn => "\u2659"
    }
  }

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

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def move_directions
    raise NotImplemented
  end

  def move_into_check?(pos)
    board_after_move = @board.dup
    board_after_move.move_piece(@position, pos)
    board_after_move.in_check?(@color)
  end

  def valid_moves
    moves.reject do |move|
      move_into_check?(move)
    end
  end

  def moves
    raise NotImplemented
  end

  def same_color?(pos)
    piece = @board[pos]
    self.color == piece.color
  end

  def to_s
    SYMBOLS[@color][self.class.to_s.to_sym]
  end
end

