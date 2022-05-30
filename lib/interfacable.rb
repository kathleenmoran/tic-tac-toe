# frozen_string_literal: true

# interface that allows user to play game again
module Interfacable
  HORIZONTAL_ROW_BORDER = '---+---+---'

  def quit_game
    puts "\nThanks for playing!"
    exit
  end

  def prompt_play_again
    puts "\nWould you like to play again? (Y/N)"
    gets.chomp.downcase
  end
end
