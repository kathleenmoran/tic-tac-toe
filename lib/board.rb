# frozen_string_literal: true

require_relative 'player'
require_relative 'interfacable'
require_relative 'calculatable'

# a tic-tac-toe board
class Board
  include Calculatable
  include Interfacable
  def initialize
    @values = make_empty_board(DIMENSION)
  end

  def win?
    horizontal_win? || vertical_win? || diagonal_win?
  end

  def to_s
    board_as_string = "\n"
    @values.each_with_index do |row, index|
      board_as_string += row_to_s(row, index)
      (board_as_string += "#{HORIZONTAL_ROW_BORDER}\n") if index < DIMENSION - 1
    end
    board_as_string
  end

  def valid_move?(move)
    move.to_i.to_s == move && move.to_i.between?(1, (DIMENSION**2)) && @values[calc_row_i(move)][calc_col_i(move)].nil?
  end

  def update(row_index, col_index, piece)
    @values[row_index][col_index] = piece
  end

  private

  def row_to_s(row, row_index)
    row_as_string = ''
    row.each_with_index do |square, column_index|
      row_as_string += square ? " #{square} " : " #{column_index + row_index * DIMENSION + 1} "
      row_as_string += column_index < DIMENSION - 1 ? '|' : "\n"
    end
    row_as_string
  end

  def horizontal_win?
    @values.any? { |row| all_x_or_o(row) }
  end

  def vertical_win?
    @values.transpose.any? { |column| all_x_or_o(column) }
  end

  def diagonal_win?
    top_bottom_diagonal = []
    bottom_top_diagonal = []
    @values.each_with_index do |row, row_index|
      top_bottom_diagonal << row[row_index]
      bottom_top_diagonal << row[DIMENSION - row_index - 1]
    end
    all_x_or_o(top_bottom_diagonal) || all_x_or_o(bottom_top_diagonal)
  end
end
