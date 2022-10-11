require_relative 'input_validation/player_name'
require_relative 'input_validation/player_symbol'
require_relative 'input_validation/location'

class Player
  include Location
  include PlayerName
  include PlayerSymbol

  attr_accessor :name, :symbol, :locations_played

  @@current_player = 1

  @@taken_name = nil
  @@taken_symbol = nil

  def initialize
    self.locations_played = []

    self.name = get_name(@@current_player, @@taken_name)
    self.symbol = get_symbol(name, @@taken_symbol)

    if @@current_player == 1
      @@taken_name = name
      @@taken_symbol = symbol
    end

    toggle_current_player
  end

  def play(board, location)
    board[location] = symbol

    locations_played << location
  end

  def toggle_current_player
    @@current_player = @@current_player == 1 ? 2 : 1
  end

  def get_location(board_locations, available_locations)
    super(name, board_locations, available_locations)
  end
end
