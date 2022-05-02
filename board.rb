require_relative 'player'

class Board
  DIMENSION = 3
  def initialize
    @values = Array.new(DIMENSION){Array.new(DIMENSION)}
    @player_1 = Player.new("X")
    @player_2 = Player.new("O")
    puts self
  end

  private
  def to_s
    board_as_string = "\n"
    @values.each_with_index do |row, index|
      board_as_string += row_to_s(row, index)
      if index < DIMENSION - 1
        board_as_string += "---+---+---" # horizontal row boarder
      end
      board_as_string += "\n"
    end
    board_as_string
  end

  private
  def row_to_s(row, row_index)
    row_as_string = ""
    row.each_with_index do |square, square_index|
      row_as_string += square ? " #{square} " : " #{square_index + row_index * 3 + 1} "
      if square_index < DIMENSION - 1
        row_as_string += "|" # vertical square boarder
      else 
        row_as_string += "\n"
      end
    end
    row_as_string
  end
end
