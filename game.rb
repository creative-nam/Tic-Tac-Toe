require_relative 'board'
require_relative 'player'

class Game
  private

  attr_accessor :player1, :player2, :board

  public

  def initialize
    self.player1 = Player.new
    self.player2 = Player.new

    self.board = Board.new(5)
  end

  private

  def announce_game_start
    puts_with_padding('=', 'NEW GAME INITIATED')

    board.display_grid
    puts ''
  end

  def announce_new_round(round)
    puts_with_padding('=', "Round #{round}")

    board.display_grid
    puts ''
  end

  def announce_game_over
    puts_with_padding '=', 'GAME OVER'
  end

  def clear_terminal
    system('cls') || system('clear')
  end

  def puts_with_padding(decorator_symbol, msg)
    10.times { print " #{decorator_symbol} " }
    print msg
    10.times { print " #{decorator_symbol} " }

    puts ''
  end

  def toggle_current_player(current_player)
    current_player == player1 ? player2 : player1
  end
end

game = Game.new

game.start
