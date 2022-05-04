require_relative 'player'

class Board
  DIMENSION = 3
  def initialize()
    @values = make_empty_board
    @player_1 = Player.new("X")
    @player_2 = Player.new("O")
    @active_player = @player_1
    play_game
  end

  private
  def make_empty_board
    Array.new(DIMENSION) { Array.new(DIMENSION) }
  end

  private
  def to_s
    board_as_string = "\n"
    horizontal_row_border = "---+---+---"
    @values.each_with_index do |row, index|
      board_as_string += row_to_s(row, index)
      if index < DIMENSION - 1
        board_as_string += horizontal_row_border
      end
      board_as_string += "\n"
    end
    board_as_string
  end

  private
  def row_to_s(row, row_index)
    row_as_string = ""
    vertical_square_border = "|"
    row.each_with_index do |square, column_index|
      row_as_string += square ? " #{square} " : " #{column_index + row_index * DIMENSION + 1} "
      if column_index < DIMENSION - 1
        row_as_string += vertical_square_border
      else 
        row_as_string += "\n"
      end
    end
    row_as_string
  end

  private
  def is_valid_move?(move)
    begin
      move_as_int = Integer(move)
    rescue => exception
      false
    else
      move_as_int.between?(1, DIMENSION**2) && @values[calc_row_index(move)][calc_square_index(move)].nil?
    end
  end

  private 
  def calc_row_index(move)
    (move - 1) / DIMENSION
  end

  private
  def calc_square_index(move)
    (move - 1) % DIMENSION
  end

  private
  def make_move
    move = @active_player.input_move
    if is_valid_move?(move)
      @values[calc_row_index(move)][calc_square_index(move)] = @active_player.piece
    else
      puts "That is an invalid move, please try again."
      make_move()
    end
  end

  private
  def change_active_player
    @active_player = (@active_player == @player_1) ? @player_2 : @player_1
  end

  private
  def has_win?
    has_horizontal_win? || has_vertical_win? || has_diagonal_win?
  end

  private 
  def has_horizontal_win?
    @values.any? { |row| all_x_or_o(row) }
  end

  private
  def has_vertical_win?
    columns = []
    for row_index in 0...DIMENSION do
      column = []
      for column_index in 0...DIMENSION do
        column << @values[row_index][column_index]
      end
      columns << column
    end
    columns.any? { |column| all_x_or_o(column) }
  end

  private
  def has_diagonal_win?
    top_bottom_diagonal = []
    bottom_top_diagonal = []
    for i in 0...DIMENSION do
      top_bottom_diagonal << @values[i][i]
      bottom_top_diagonal << @values[i][DIMENSION - i - 1]
    end
    all_x_or_o(top_bottom_diagonal) || all_x_or_o(bottom_top_diagonal)
  end

  private
  def all_x_or_o(squares)
    unique_pieces = squares.uniq
    !unique_pieces.include?(nil) && unique_pieces.size == 1
  end

  private
  def take_turn
    puts self
    make_move
  end

  private
  def play_game
    puts "\nLet's play tic-tac-toe!"
    (DIMENSION**2).times do
      take_turn
      break if has_win?
      change_active_player
    end
    end_game
  end

  private
  def end_game
    puts self
    puts "\nGAME OVER"
    if has_win?
      @active_player.declare_winner
    else
      puts "\nIt's a tie!"
    end
    ask_to_play_again
  end

  private
  def ask_to_play_again
    puts "\nWould you like to play again? (Y/N)"
    user_input = gets.chomp.downcase
    if user_input == 'y' || user_input == 'yes'
      reset_board
      play_game
    elsif user_input == 'n' || user_input == 'no'
      puts "\nThanks for playing!"
      exit 
    else
      puts "That's in an invalid response."
      ask_to_play_again
    end
  end

  private
  def reset_board
    @values = make_empty_board
    @active_player = @player_1
  end
end
