require_relative 'player'

class Board
  def initialize(dimension=3)
    @dimension = dimension
    @values = Array.new(@dimension){Array.new(@dimension)}
    @player_1 = Player.new("X")
    @player_2 = Player.new("O")
    @active_player = @player_1
    puts self
  end

  private
  def to_s
    board_as_string = "\n"
    HORIZONTAL_ROW_BORDER = "---+---+---"
    @values.each_with_index do |row, index|
      board_as_string += row_to_s(row, index)
      if index < @dimension - 1
        board_as_string += HORIZONTAL_ROW_BORDER
      end
      board_as_string += "\n"
    end
    board_as_string
  end

  private
  def row_to_s(row, row_index)
    row_as_string = ""
    VERTICAL_SQUARE_BORDER = "|"
    row.each_with_index do |square, square_index|
      row_as_string += square ? " #{square} " : " #{square_index + row_index * 3 + 1} "
      if square_index < @dimension - 1
        row_as_string += VERTICAL_SQUARE_BORDER
      else 
        row_as_string += "\n"
      end
    end
    row_as_string
  end

  private
  def is_valid_move?(move)
    @values[calc_row_index(move)][calc_square_index(move)].is_nil?
  end

  private 
  def calc_row_index(move)
    move / @dimension
  end

  private
  def calc_square_index(move)
    move % (@dimension - 1)
  end

  private
  def make_move
    move = @active_player.input_move
    if is_valid_move?(move)
      @values[calc_row_index(move)][calc_square_index(move)] = @active_player.piece
      change_active_player
    else
      puts "That is an invalid move, please try again."
      make_move()
    end
  end
end
