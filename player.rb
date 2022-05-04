require_relative 'board'

class Player
  @@total_players = 0
  attr_reader :piece
  def initialize(piece)
    @name = input_name
    @piece = piece
    @@total_players += 1
    puts self
  end

  def input_move
    puts "\n#{@name}, please enter a number (1-9) that is available to place a '#{piece}'."
    gets.chomp.to_i
  end

  def declare_winner
    puts "\n#{@name} won!"
  end

  private
  def input_name
    puts "\nWhat is the name of player #{@@total_players + 1}?"
    gets.chomp
  end 

  private
  def to_s
    "#{@name}, your piece is '#{@piece}'."
  end
end