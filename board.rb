require_relative 'pieces'
require_relative "invalid_move_error"
require 'pp'

class Board
  attr_reader :rows, :piece_bins

  def initialize
    create_board
    place_pieces
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

  def move_piece(from_pos, to_pos)
    piece_to_move = self[from_pos]
    raise InvalidMoveError if piece_to_move.nil?
    raise InvalidMoveError if invalid_move?(piece_to_move, to_pos)

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
    false
  end

  def dup
    new_board = Board.new
    8.times do |pos_x|
      8.times { |pos_y| new_board[[pos_x, pos_x]] = self[[pos_x, pos_y]].dup }
    end
    new_board
  end

  def in_bounds?(pos)
    pos.all? { |el| el.between?(0, 7) }
  end

  def on_piece?(pos)
    !!self[pos]
  end

  def check?(move = nil)

  end

  def in_check_mate?
    false
  end

  def place_color(color, row_coords)
    pawn_y = row_coords[:pawn]
    pieces_y = row_coords[:pieces]
    self[[0, pieces_y]] = Rook.new([0, pieces_y], color, self)
    self[[7, pieces_y]] = Rook.new([7, pieces_y], color, self)
    self[[1, pieces_y]] = Knight.new([1, pieces_y], color, self)
    self[[6, pieces_y]] = Knight.new([6, pieces_y], color, self)
    self[[2, pieces_y]] = Bishop.new([2, pieces_y], color, self)
    self[[5, pieces_y]] = Bishop.new([5, pieces_y], color, self)
    self[[3, pieces_y]] = Queen.new([3, pieces_y], color, self)
    self[[4, pieces_y]] = King.new([4, pieces_y], color, self)
    (0..7).each { |i| self[[i, pawn_y]] = Pawn.new([i, pawn_y], color, self) }
  end

  def place_pieces
    place_color(:white, :pawn => 1, :pieces => 0)
    place_color(:black, :pawn => 6, :pieces => 7)
  end
end