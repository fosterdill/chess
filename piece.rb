class Piece
  attr_accessor :position
  attr_reader :color

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
  end

  def move_dirs
    raise NotImplemented
  end

  def moves
    raise NotImplemented
  end

  def in_bounds?(pos)
    pos_x, pos_y = pos[0], pos[1]
    return false if pos_x > 8 || pos_x < 0
    return false if pos_y > 8 || pos_y < 0
    true
  end

  def on_piece?(pos)
    pos_x, pos_y = pos[0], pos[1]
    return false if @board.rows[pos_x][pos_y]
    true
  end
end