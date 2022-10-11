require_relative 'board_representation'
require_relative 'input_validation/board_dimension'
require_relative 'winning_logic'

class Board
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

  def populate_grid(grid)
    populated_grid = grid
    location_number = 1

    populated_grid.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        populated_grid[row_index][col_index] = location_number

        location_number += 1
      end
    end

    populated_grid
  end

  def generate_locations_map(grid)
    locations_map = {}
    location = 1

    grid.each_with_index do |row, row_index|
      row.each_with_index do |_col, col_index|
        locations_map[location] = [row_index, col_index]

        location += 1
      end
    end

    locations_map
  end

  def convert_index_to_location(grid_index)
    equivalent_location = nil

    locations_map.each do |location, index|
      equivalent_location = location if grid_index == index
    end

    equivalent_location
  end
end
