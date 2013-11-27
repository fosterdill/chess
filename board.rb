require_relative 'pieces'
require_relative "invalid_move_error"
require 'pp'

class Board
  attr_reader :rows, :piece_bins

  def initialize(duplicated = false)
    create_board
    place_pieces unless duplicated
    @piece_bins = { :black => [], :white => [] }
  end

  def create_board
    @rows = Array.new(8) { Array.new(8) }
  end

  def display
    puts "\n   A  B  C  D  E  F  G  H"
    @rows.transpose.reverse.each_with_index do |row, index|
      print "#{8 - index} "
      row.each do |tile|
        tile.nil? ? (print "|__") : (print "|#{tile.to_s} ")
      end
      print "|\n"
    end
    puts "   A  B  C  D  E  F  G  H"
  end

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []= (pos, piece)
    row, col = pos
    @rows[row][col] = piece
  end

  def move_piece(from_pos, to_pos, move_made = false)
    piece_to_move = self[from_pos]
    unless move_made
      raise InvalidMoveError if piece_to_move.nil?
      raise InvalidMoveError if invalid_move?(piece_to_move, to_pos)
    end

    if on_piece?(to_pos)
      piece_at_spot = self[to_pos]
      @piece_bins[piece_at_spot.color] << piece_at_spot
    end

    piece_to_move.position = to_pos
    self[to_pos], self[from_pos] = piece_to_move, nil
  end

  def invalid_move?(piece, to_pos)
    [
      :puts_self_in_check?,
      :invalid_piece_movement?,
    ].any? { |validity_check| send(validity_check, piece, to_pos) }
  end

  def invalid_piece_movement?(piece, to_pos)
    !piece.moves.include?(to_pos)
  end

  def puts_self_in_check?(piece, to_pos)
    # board_after_move = self.dup
    # board_after_move.move_piece(piece.position, to_pos, true)
    # puts "move made"
    # p to_pos
    # board_after_move.in_check?(piece.color)
    false
  end

  def dup
    new_board = Board.new(true)
    self.each_piece do |piece|
      new_board[piece.position] = piece.class.new(piece.position.dup,
                                                  piece.color,
                                                  new_board)
    end
    new_board
  end

  def in_bounds?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

  def on_piece?(pos)
    !!self[pos]
  end

  def in_check?(color)
    # king_pos = find_king_for(color).position

    self.each_piece do |piece|
      next if piece.color == color

      if piece.moves.any?{ |mv| self[mv].class == King }
        return true
      end
    end

    false
  end

  def each_piece(&prc)
    @rows.each do |row|
      row.each do |piece|
        next if piece.nil?
        prc.call(piece)
      end
    end
  end

  def winner
    in_check?(:white) ? 'Black' : 'White'
  end

  def in_check_mate?(color)
    return false unless in_check?(color)

    self.each_piece do |piece|
      next if color != piece.color
      piece.moves.each do |move|

        board_after_move = self.dup

        board_after_move.move_piece(piece.position, move)

        return false unless board_after_move.in_check?(color)
      end
    end

    true
  end

  def place_color(color, row_coords)
    pawn_y = row_coords[:pawn]
    pieces_y = row_coords[:pieces]
    self[[0, pieces_y]] = Rook.new([0, pieces_y], color, self)
    self[[7, pieces_y]] = Rook.new([7, pieces_y], color, self)
    self[[1, pieces_y]] = Knight.new([1, pieces_y], color, self)
    self[[6, pieces_y]] = Knight.new([6, pieces_y], color, self)
    self[[2, pieces_y]] = Bishop.new([2, pieces_y], color, self)
    self[[5, pieces_y]] = Rook.new([5, pieces_y], color, self)
    self[[3, pieces_y]] = Queen.new([3, pieces_y], color, self)
    self[[4, pieces_y]] = King.new([4, pieces_y], color, self)
    (0..7).each { |i| self[[i, pawn_y]] = Pawn.new([i, pawn_y], color, self) }
  end

  def place_pieces
    place_color(:white, :pawn => 1, :pieces => 0)
    place_color(:black, :pawn => 6, :pieces => 7)
    self[[5, 4]] = Knight.new([5, 4], :white, self)
  end
end

# b = Board.new
# b.move_piece([0, 1], [0, 2])
#
# d = b.dup

# d.move_piece([0, 1], [0, 2])
# p b[[0, 1]]
# p d[[0, 1]]
#
# b.display
# d.display