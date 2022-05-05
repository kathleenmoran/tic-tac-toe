# frozen_string_literal: true

# a player in a tic-tac-toe game
class Player
  attr_reader :piece

  def initialize(piece, number)
    @piece = piece
    @number = number
    @name = input_name
    puts self
  end

  def input_move
    puts "\n#{@name}, please enter a number (1-9) that is available to place a '#{piece}'."
    gets.chomp
  end

  def declare_winner
    puts "\n#{@name} won!"
  end

  private

  def input_name
    puts "\nWhat is the name of player #{@number}?"
    gets.chomp
  end

  def to_s
    "#{@name}, your piece is '#{@piece}'."
  end
end
