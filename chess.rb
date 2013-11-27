require_relative "board"
class Chess
  LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  def initialize
    @board = Board.new
  end

  def get_move
    puts "\nEnter a piece to move <A6>:"
    move_from = gets.chomp
    puts "Enter a position to move to:"
    move_to = gets.chomp

    #convert ['A', '5'] into [0, 4]
    move_from = [LETTERS.index(move_from[0].upcase), move_from[1].to_i - 1]
    move_to = [LETTERS.index(move_to[0].upcase), move_to[1].to_i - 1]

    [move_from, move_to]
  end

  def play
    until @board.in_check_mate?
      @board.display
      begin
        move = get_move
        @board.move_piece(*move)
      rescue InvalidMoveError
        puts "Please play a legal move!"
        retry
      end
    end

    puts "#{@board.winner} is the winner!"
  end
end

game = Chess.new
game.play