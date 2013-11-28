require_relative 'board'
require_relative 'human_player'
require_relative 'errors'
require 'yaml'

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
      puts "\n#{@turn.capitalize}'s turn!"
      self.play_turn
      self.switch_turns
    end

    puts "#{@board.winner} is the winner!"
  end
  
  def switch_turns
    @turn = (@turn == :white ? :black : :white)
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
      return save_file if move == "SAVE"
      return load_file if move == "LOAD"
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
    rescue InvalidInputError
      puts "\nWrong format. Correct format <A1,A2>.\n"
      retry
    end
  end

  def save_file
    self.switch_turns
    serialized_board = [@board, @turn].to_yaml
    File.open("chess.sav", "w") { |f| f.puts(serialized_board) }
    puts "\n**Game Saved**"
  end

  def load_file
    serialized_board = YAML::load_file("chess.sav")
    @board = serialized_board[0]
    @turn = serialized_board[1]
    puts "\n**Game Loaded**"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end