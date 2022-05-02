require_relative 'board'

class Player
  @@total_players = 0
  def initialize(piece)
    @name = input_name
    @piece = piece
    @@total_players += 1
    puts self
  end

  private
  def input_name
    puts "What is the name of player #{@@total_players + 1}?"
    gets.chomp
  end 

  private
  def to_s
    "#{@name}, your piece is '#{@piece}'."
  end

  private
  def input_move
    puts "#{@name}, please enter a number (1-9) that is available to place a '#{piece}'."
    gets.chomp.to_i - 1
  end
end