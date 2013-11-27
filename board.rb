require_relative 'pieces'
require 'pp'

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

  def in_bounds?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

  def on_piece?(pos)
    !!self[pos]
  end

  def check?(move = nil)

  end

  def inspect
    result = ""
    @rows.transpose.reverse.each do |row|
      result += row.inspect + "\n"
    end
    result
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

c = Pawn.new([1, 2], :white, board)
#d = Pawn.new([1, 2], :white, board)
e = Pawn.new([2, 2], :black, board)

board[[1, 2]] = c
#board[[1, 2]] = d
board[[2, 2]] = e

pp board

#p a.moves
#p b.moves
p c.moves
p e.moves