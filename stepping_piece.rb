require_relative 'piece'

class SteppingPiece < Piece
  def moves
    moves = []

    move_directions.each do |direction|
      new_pos = [self.position[0] + direction[0],
                 self.position[1] + direction[1]]
      next unless @board.in_bounds?(new_pos)
      moves << new_pos unless @board.on_piece?(new_pos) && same_color?(new_pos)
    end

    moves
  end
end