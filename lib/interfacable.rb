# frozen_string_literal: true

# interface that allows user to play game again
module Interfacable
  HORIZONTAL_ROW_BORDER = '---+---+---'

  def play_tic_tac_toe_message
    puts "\nLet's play tic-tac-toe!"
  end

  def invalid_move_message
    puts 'That is an invalid move, please try again.'
  end

  def game_over_message
    puts "\nGAME OVER"
  end

  def tie_message
    puts "It's a tie!"
  end

  def input_move_message(name, piece)
    puts "\n#{name}, please enter a number (1-9) that is available to place a '#{piece}'."
  end

  def declare_winner_message(name)
    puts "\n#{name} won!"
  end

  def input_name_message(player_number)
    puts "\nWhat is the name of player #{player_number}?"
  end

  def print_player(name, piece)
    "#{name}, your piece is '#{piece}'."
  end
end
