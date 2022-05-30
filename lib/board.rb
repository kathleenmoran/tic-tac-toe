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
    @player1 = Player.new('X', 1)
    @player2 = Player.new('O', 2)
    @active_player = @player1
  end

  def play_game
    puts "\nLet's play tic-tac-toe!"
    (DIMENSION**2).times do
      make_move
      break if win?

      @active_player = @active_player == @player1 ? @player2 : @player1
    end
    end_game
  end

  private

  def to_s
    board_as_string = "\n"
    @values.each_with_index do |row, index|
      board_as_string += row_to_s(row, index)
      (board_as_string += "#{HORIZONTAL_ROW_BORDER}\n") if index < DIMENSION - 1
    end
    board_as_string
  end

  def row_to_s(row, row_index)
    row_as_string = ''
    row.each_with_index do |square, column_index|
      row_as_string += square ? " #{square} " : " #{column_index + row_index * DIMENSION + 1} "
      row_as_string += column_index < DIMENSION - 1 ? '|' : "\n"
    end
    row_as_string
  end

  def valid_move?(move)
    move.to_i.to_s == move && move.to_i.between?(1, (DIMENSION**2)) && @values[calc_row_i(move)][calc_col_i(move)].nil?
  end

  def make_move
    puts self
    move = @active_player.input_move
    if valid_move?(move)
      @values[calc_row_i(move)][calc_col_i(move)] = @active_player.piece
    else
      puts 'That is an invalid move, please try again.'
      make_move
    end
  end

  def win?
    horizontal_win? || vertical_win? || diagonal_win?
  end

  def horizontal_win?
    @values.any? { |row| all_x_or_o(row) }
  end

  def vertical_win?
    columns = []
    @values.each_with_index do |row, row_index|
      new_column = []
      row.each_with_index do |_square, column_index|
        new_column << @values[column_index][row_index]
      end
      columns << new_column
    end
    columns.any? { |column| all_x_or_o(column) }
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

  def end_game
    puts self
    puts "\nGAME OVER"
    if win?
      @active_player.declare_winner
    else
      puts "\nIt's a tie!"
    end
    ask_to_play_again
  end

  def ask_to_play_again
    user_input = prompt_play_again
    if %w[y yes].include?(user_input)
      reset_board
      play_game
    elsif %w[n no].include?(user_input)
      quit_game
    else
      puts "That's an invalid response."
      ask_to_play_again
    end
  end

  def reset_board
    @values = make_empty_board(DIMENSION)
    @active_player = @player1
  end
end
