# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'interfacable'

# a game of tic-tac-toe
class Game
  include Interfacable
  include Calculatable
  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new('X', 1)
    @player2 = Player.new('O', 2)
    @active_player = @player1
  end

  def play
    play_tic_tac_toe_message
    (DIMENSION**2).times do
      make_move
      break if @board.win?

      @active_player = @active_player == @player1 ? @player2 : @player1
    end
    end_game
  end

  def make_move
    puts @board
    move = @active_player.input_move
    if @board.valid_move?(move)
      @board.update(calc_row_i(move), calc_col_i(move), @active_player.piece)
    else
      invalid_move_message
      make_move
    end
  end

  def end_game
    puts @board
    game_over_message
    if @board.win?
      @active_player.declare_winner
    else
      tie_message
    end
  end
end
