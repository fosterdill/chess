require_relative 'sliding_piece'
class Bishop
  def move_directions
    MOVE_DIRECTIONS[:diagonals]
  end
end