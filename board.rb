class Board
  attr_reader :rows

  def self.create_board
    @rows = Array.new(8) { Array.new(8) }
  end

  LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  def [](pos)
    col, row = pos.split('')
    @rows[LETTERS.index(col)][row - 1]
  end

  def initialize

  end

  def check?(move = nil)

  end
end