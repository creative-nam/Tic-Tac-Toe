require_relative 'helper_classes/location.rb'
require_relative 'winning_logic.rb'

class Board
  include Location
  include WinningLogic

  attr_reader :locations, :available_locations, :winning_combinations

  private

  attr_writer :locations,  :available_locations, :winning_combinations

  attr_accessor :grid, :board_dimension, :amount_of_locations, :locations_map

  public

  def initialize(board_dimension)
    self.board_dimension = board_dimension
    self.amount_of_locations = board_dimension**2

    self.grid = Array.new(board_dimension) { Array.new(board_dimension) }
    self.grid = populate_grid(grid)

    self.locations_map = generate_locations_map(grid)
    self.locations = locations_map.keys
    self.available_locations = locations_map.keys

    self.winning_combinations = find_winning_combinations(grid, board_dimension)
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

  def display_grid
    puts generate_grid_output(amount_of_locations)
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

  def generate_grid_output(amount_of_locations)
    grid_output = ''

    max_location_digits = get_location_digits(amount_of_locations)

    underscores = ''
    max_location_digits.times { underscores += '_' }

    space_between_numbers = ' ' + ' ' + ' ' + ' ' + ' '
    lines_separation = underscores + space_between_numbers

    grid_output += "\t"
    grid.length.times { grid_output += lines_separation }

    current_location_number = locations.min

    grid.each_with_index do |row, row_index|
      grid_output += "\n" + "\t" + "\n" + "\t"

      row.each_with_index do |_col, col_index|
        current_square = grid[row_index][col_index]

        length_difference = max_location_digits - find_square_length(current_square)
        length_difference.times { grid_output += ' ' }

        grid_output += current_square.to_s
        grid_output += ' ' + ' ' + '|' + ' ' + ' ' unless col_index == row.length - 1

        current_location_number += 1
      end

      grid_output += "\n" + "\t"
      grid.length.times { grid_output += lines_separation }
    end

    grid_output
  end

  def get_location_digits(location_number)
    (Math.log10(location_number) + 1).to_i
  end

  # Determines wether or not the a given square has been "filled", ie:
  # selected/played by one of the players.
  # If its value is an integer, it hasn't been touched since we called populate_grid,
  # so we know it hasn't been selected. Otherwise, it'll be a string - the
  # symbol of the player which has selected it. And in that case, it has been filled.

  def square_filled?(grid_square)
    grid_square.instance_of?(String)
  end

  def find_square_length(square)
    square_filled?(square) ? square.length : get_location_digits(square)
  end
end

# Don't mind the pieces of code bellow, i'm just testing the class
# as i go, to check if it's producing the desired behaviors/results

# I'll remove it once i'm done with the class, so if you you're in this
# commit, coming from a point where the class is already complete,
# don't mind the discrepancy, there's nothing important about it.
