require_relative 'piece'

class SlidingPiece < Piece
  def moves
    moves = []

    move_directions.each do |direction|
      new_pos = [self.position[0] + direction[0],
                 self.position[1] + direction[1]]
      moves += move_in_direction(new_pos, direction)
    end

    moves
  end

  def move_in_direction(pos, direction)
    return [] unless @board.in_bounds?(pos)

    if(@board.on_piece?(pos))
      return (same_color?(pos) ? [] : [pos])
    end

    new_pos = [pos[0] + direction[0], pos[1] + direction[1]]
    [pos] + move_in_direction(new_pos, direction)
  end

  def move_directions
    raise NotImplemented
  end
end
