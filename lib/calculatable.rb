# frozen_string_literal: true

# calculations for tic-tac-toe game
module Calculatable
  DIMENSION = 3
  def make_empty_board(dimension)
    Array.new(dimension) { Array.new(dimension) }
  end

  def calc_row_i(move)
    (move.to_i - 1) / DIMENSION
  end

  def calc_col_i(move)
    (move.to_i - 1) % DIMENSION
  end

  def all_x_or_o(squares)
    unique_pieces = squares.uniq
    !unique_pieces.include?(nil) && unique_pieces.size == 1
  end
end
