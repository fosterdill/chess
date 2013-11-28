class HumanPlayer
  LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

  def initialize(color)
    @color = color
  end

  def get_move
    puts "\nEnter a piece to move <A6,E5>:"
    move_from, move_to = gets.chomp.split(/,\s*/)

    parse_input(move_from, move_to)
  end

  def parse_input(move_from, move_to)
    #convert ['A', '5'] into [0, 4]
    move_from = [LETTERS.index(move_from[0].upcase), move_from[1].to_i - 1]
    move_to = [LETTERS.index(move_to[0].upcase), move_to[1].to_i - 1]

    [move_from, move_to]
  end
end