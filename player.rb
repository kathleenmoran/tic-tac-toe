require_relative 'board'

class Player
  @@total_players = 0
  def initialize(piece, board)
    @name = input_name
    @piece = piece
    @board = board
    @@total_players += 1
  end

  def input_name
    puts "What is the name of player #{@@total_players + 1}?"
    gets.chomp
  end 
end
