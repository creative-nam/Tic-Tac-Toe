require_relative 'helper_classes/location'
require_relative 'winning_logic'

class Board
  include Location
  include WinningLogic

  attr_reader :locations, :available_locations, :winning_combinations

  private

  attr_writer :locations, :available_locations, :winning_combinations

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
    grid_output = break_line_and_indent(grid_output)

    current_location_number = locations.min
    max_location_digits = get_location_digits(amount_of_locations)

    grid_output = separate_line(grid_output, grid.length, max_location_digits)

    grid.each do |row|
      grid_output = break_line_and_indent(grid_output, 2)

      row.each_with_index do |col, col_index|
        grid_output = add_whitespace_padding(grid_output, max_location_digits, col)
        grid_output += col.to_s
        grid_output = add_char_separator(grid_output) unless col_index == row.length - 1

        current_location_number += 1
      end

      grid_output = break_line_and_indent(grid_output, 2)
      grid_output = separate_line(grid_output, grid.length, max_location_digits)
    end

    grid_output
  end

  def add_char_separator(board_representation)
    whitespace_between_chars = ' ' + ' '
    separator_char = '|'

    board_representation += whitespace_between_chars + separator_char + whitespace_between_chars

    board_representation
  end

  def break_line_and_indent(board_representation, amount_of_times = 1)
    amount_of_times.times { board_representation += "\n" + "\t" }

    board_representation
  end

  def separate_line(board_representation, chars_in_line, max_digits_to_cover)
    trail_char = ''
    max_digits_to_cover.times { trail_char += '-' }
    whitespace_between_chars = ' ' + ' '
    separator_char = '+'

    space_between_chars = whitespace_between_chars + separator_char + whitespace_between_chars

    lines_separation = trail_char + space_between_chars

    current_char = 1

    chars_in_line.times do
      last_char = current_char == chars_in_line
      board_representation += last_char ? trail_char : lines_separation

      current_char += 1
    end

    board_representation
  end

  def add_whitespace_padding(board_representation, max_location_digits, grid_square)
    length_difference = max_location_digits - find_element_length(grid_square)
    length_difference.times { board_representation += ' ' }

    board_representation
  end

  def get_location_digits(location_number)
    (Math.log10(location_number) + 1).to_i
  end

  # Determines wether or not the a given square has been "filled", ie:
  # selected/played by one of the players.
  # If its value is an integer, it hasn't been touched since we called populate_grid,
  # so we know it hasn't been selected. Otherwise, it'll be a string - the
  # symbol of the player which has selected it. And in that case, it has been filled.

  def element_filled?(grid_square)
    grid_square.instance_of?(String)
  end

  def find_element_length(grid_square)
    element_filled?(grid_square) ? grid_square.length : get_location_digits(grid_square)
  end
end

# Don't mind the pieces of code bellow, i'm just testing the class
# as i go, to check if it's producing the desired behaviors/results

# I'll remove it once i'm done with the class, so if you you're in this
# commit, coming from a point where the class is already complete,
# don't mind the discrepancy, there's nothing important about it.
