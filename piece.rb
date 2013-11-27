class Piece
  attr_accessor :position
  attr_reader :color

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

  def moves
    raise NotImplemented
  end

  def in_bounds?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

  def on_piece?(pos)
    !!@board[pos]
  end

  def same_color?(pos)
    piece = @board[pos]
    self.color == piece.color
  end
end

