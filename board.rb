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
    col, row = pos.split('')
    @rows[LETTERS.index(col)][row.to_i - 1]
  end

  def []= (pos, piece)
    col, row = pos.split('')
    @rows[LETTERS.index(col)][row.to_i - 1] = piece
  end

  def check?(move = nil)

  end
end

board = Board.new

a = Bishop.new([1, 1], :white, board)
board["B2"] = a

b = Rook.new([6, 6], :white, board)
board["G7"] = b

q = Queen.new([4, 4], :white, board)
board["E5"] = q

#p a.moves
#p b.moves
p q.moves