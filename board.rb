require_relative 'helper_methods/board_dimension'
require_relative 'helper_methods/board_representation'
require_relative 'helper_methods/location'
require_relative 'winning_logic'

class Board
  include Location
  include WinningLogic
  include BoardDimension

  attr_reader :locations, :available_locations, :winning_combinations

  private

  attr_writer :locations, :available_locations, :winning_combinations

  attr_accessor :grid, :dimension, :amount_of_locations, :locations_map

  public

  def initialize
    self.dimension = get_dimension
    self.amount_of_locations = dimension**2

    self.grid = Array.new(dimension) { Array.new(dimension) }
    self.grid = populate_grid(grid)

    self.locations_map = generate_locations_map(grid)
    self.locations = locations_map.keys
    self.available_locations = locations_map.keys

    self.winning_combinations = find_winning_combinations(grid, dimension)
  end

  def [](location)
    row, col = locations_map[location]

    grid[row][col]
  end

  def []=(location, player_symbol)
    row, col = locations_map[location]

    grid[row][col] = player_symbol

    update_available_locations(available_locations, location)
  end

  def display_board
    puts BoardRepresentation.new(grid, locations.min, locations.max).representation
  end

  def winner?(player)
    super(player.locations_played, winning_combinations)
  end

  private

  def update_available_locations(available_locations, location_played)
    available_locations.delete(location_played)

    self.available_locations = available_locations
  end

  def convert_index_to_location(grid_index)
    super(locations_map, grid_index)
  end
end

# Don't mind the pieces of code bellow, i'm just testing the class
# as i go, to check if it's producing the desired behaviors/results

# I'll remove it once i'm done with the class, so if you you're in this
# commit, coming from a point where the class is already complete,
# don't mind the discrepancy, there's nothing important about it.
