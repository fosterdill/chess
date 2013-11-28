require_relative 'board'
require_relative 'human_player'
require_relative 'errors'

class Chess
  attr_reader :board, :turn

  def initialize
    @board = Board.new
    @turn = :white
    @players = {
      :white => HumanPlayer.new(:white),
      :black => HumanPlayer.new(:black)
    }
  end

  def play
    until game_over?
      @board.display
      self.play_turn
      @turn = (@turn == :white ? :black : :white)
    end

    puts "#{@board.winner} is the winner!"
  end

  def game_over?
    @board.in_check_mate?(:white) || @board.in_check_mate?(:black)
  end

  def validate_move(move)
    piece = board[move[0]]
    raise IncorrectColorError if piece.nil? || piece.color != @turn
    raise MoveIntoCheckError if piece.move_into_check?(move[1])
    raise InvalidMoveError unless piece.moves.include?(move[1])
  end

  def play_turn
    begin
      move = @players[@turn].get_move
      validate_move(move)
      board.move_piece(*move)
    rescue IncorrectColorError
      puts "\nPlease move a #{@turn} piece.\n"
      retry
    rescue MoveIntoCheckError
      puts "\nCannot move into check!\n"
      retry
    rescue InvalidMoveError
      puts "\nPlease play a legal move!\n"
      retry
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end