require_relative 'player'

class Board
  DIMENSION = 3
  def initialize
    @values = Array.new(DIMENSION){Array.new(DIMENSION)}
    @player_1 = Player.new("X", self)
    @player_2 = Player.new("O", self)
  end
end
