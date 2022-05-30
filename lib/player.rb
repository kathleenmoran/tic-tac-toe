# frozen_string_literal: true

require_relative 'interfacable'

# a player in a tic-tac-toe game
class Player
  include Interfacable
  attr_reader :piece

  def initialize(piece, number)
    @piece = piece
    @number = number
    @name = input_name
    puts self
  end

  def input_move
    input_move_message(@name, @piece)
    gets.chomp
  end

  def declare_winner
    declare_winner_message(@name)
  end

  private

  def input_name
    input_name_message(@number)
    gets.chomp
  end

  def to_s
    print_player(@name, @piece)
  end
end
