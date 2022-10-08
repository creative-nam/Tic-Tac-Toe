require_relative 'helper_classes/player_name'
require_relative 'helper_classes/player_symbol'
require_relative 'helper_classes/location'

class Player
  include Location
  include PlayerName

  attr_accessor :name, :symbol, :locations_played

  @@current_player = 1

  @@taken_name = nil
  @@taken_symbol = nil

  def initialize
    self.locations_played = []

    self.name = get_name(@@current_player, @@taken_name)
    self.symbol = PlayerSymbol.new(name, @@taken_symbol).value

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

# Don't mind the pieces of code bellow, i'm just testing the class
# as i go, to check if it's producing the desired behaviors/results

# I'll remove it once i'm done with the class, so if you you're in this
# commit, coming from a point where the class is already complete,
# don't mind the discrepancy, there's nothing important about it.

# p1 = Player.new()

# puts "Your name is: #{p1.name}"
# puts "Your symbol is: #{p1.symbol}"
