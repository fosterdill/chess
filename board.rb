require_relative 'pieces'
require 'colorize'

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

  def switch_color(color)
    color == :light_red ? :red : :light_red
  end

  def add_color(board_space, tile, board_color)
    piece_color = (tile ? tile.color : :black)
    print board_space.colorize(:background => switch_color(board_color),
                               :color => piece_color)
  end

  def display
    puts "\n A B C D E F G H"
    board_color = switch_color(board_color)
    @rows.transpose.reverse.each_with_index do |row, index|
      print "#{8 - index}"
      board_color = switch_color(board_color)
      row.each do |tile|
        board_space = (tile.nil? ? ("  ") : ("#{tile.to_s} "))
        add_color(board_space, tile, board_color)
        board_color = switch_color(board_color)
      end
      print "\n"
    end
    puts " A B C D E F G H"
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
    piece_to_move.position = to_pos
    self[to_pos], self[from_pos] = piece_to_move, nil
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
    !self[pos].nil?
  end

  def in_check?(color)
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
      return false unless piece.valid_moves.empty?
    end

    true
  end

  def place_color(color, row_coords)
    piece_types = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    pawn_y = row_coords[:pawn]
    pieces_y = row_coords[:pieces]

    piece_types.each_with_index do |type, i|
      self[[i, pieces_y]] = type.new([i, pieces_y], color, self)
    end
    (0..7).each { |i| self[[i, pawn_y]] = Pawn.new([i, pawn_y], color, self) }
  end

  def place_pieces
    place_color(:white, :pawn => 1, :pieces => 0)
    place_color(:black, :pawn => 6, :pieces => 7)
  end
end