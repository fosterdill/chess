require_relative 'pieces'

class Board
  attr_reader :rows

  def initialize
    create_board
  end

  def create_board
    @rows = Array.new(8) { Array.new(8) }
  end

  LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []= (pos, piece)
    row, col = pos
    @rows[row][col] = piece
  end

  def check?(move = nil)

  end

  # def chess_to_arr(pos_str)
  #
  # end
  #
  # def arr_to_chess(pos)
  #
  # end
end

board = Board.new

# a = Knight.new([1, 1], :white, board)
# board[[1,1]] = a
#
# b = Rook.new([3, 2], :black, board)
# board[[3, 2]] = b

# q = Queen.new([4, 4], :white, board)
# board[[4,4]] = q

#p a.moves
#p b.moves
p a.moves