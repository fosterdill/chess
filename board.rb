require_relative 'pieces'
require 'pp'

class Board
  attr_reader :rows
  
  LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  def initialize
    create_board
    place_pieces
  end

  def create_board
    @rows = Array.new(8) { Array.new(8) }
  end
  
  def place_pieces
    self[[0, 0]] = Rook.new([0, 0], :white, self)
    self[[7, 0]] = Rook.new([7, 0], :white, self)
    self[[1, 0]] = Knight.new([1, 0], :white, self)
    self[[6, 0]] = Knight.new([6, 0], :white, self)
    self[[2, 0]] = Bishop.new([2, 0], :white, self)
    self[[5, 0]] = Bishop.new([5, 0], :white, self)
    self[[3, 0]] = Queen.new([3, 0], :white, self)
    self[[4, 0]] = King.new([4, 0], :white, self)
    (0..7).each { |i| self[[i, 1]] = Pawn.new([i, 1], :white, self) }
    
    self[[0, 7]] = Rook.new([0, 7], :black, self)
    self[[7, 7]] = Rook.new([7, 7], :black, self)
    self[[1, 7]] = Knight.new([1, 7], :black, self)
    self[[6, 7]] = Knight.new([6, 7], :black, self)
    self[[2, 7]] = Bishop.new([2, 7], :black, self)
    self[[5, 7]] = Bishop.new([5, 7], :black, self)
    self[[3, 7]] = Queen.new([3, 7], :black, self)
    self[[4, 7]] = King.new([4, 7], :black, self)
    (0..7).each { |i| self[[i, 6]] = Pawn.new([i, 6], :black, self) }
  end
  
  def display
    @rows.transpose.reverse.each do |row|
      row.each do |tile|
        tile.nil? ? (print "|__") : (print "|#{tile.to_s} ")
      end
      print "|\n"
    end
  end

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

# c = Pawn.new([1, 2], :white, board)
# #d = Pawn.new([1, 2], :white, board)
# e = Pawn.new([2, 2], :black, board)
# 
# board[[1, 2]] = c
# #board[[1, 2]] = d
# board[[2, 2]] = e

#pp board

#p a.moves
#p b.moves
# p c.moves
# p e.moves

board.display