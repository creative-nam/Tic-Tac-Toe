module Location
  private

  def get_location(player_name, board_locations, available_locations)
    location = nil

    until valid_location?(location, board_locations, available_locations)
      puts "Where would you like to play #{player_name}?"
      location = gets.chomp

      unless valid_location?(location, board_locations, available_locations)
        error_to_output = find_location_error(location, board_locations, available_locations)
        puts error_to_output
      end
    end

    location.to_i
  end

  # Here we're trying to find out if the location the user inputted is
  # indeed a number (as it should be).
  # So to do that, we'll attempt to convert that location from a string
  # (returned by the gets method) to an int. If the location is indeed
  # a number, to_i will return it as an int; otherwise it'll return 0.

  # An edge case would be if the location is "0". So we'll check directly
  # for that directly.

  def valid_location_format?(location)
    return true if location == '0'

    location == location.to_i.to_s
  end

  def in_range?(location, board_locations)
    board_locations.include?(location.to_i)
  end

  def available_location?(location, available_locations)
    available_locations.include?(location.to_i)
  end

  def valid_location?(location, board_locations, available_locations)
    valid_location_format?(location) && in_range?(location, board_locations) && available_location?(location, available_locations)
  end

  def find_location_error(location, board_locations, available_locations)
    if !valid_location_format?(location)
      invalid_location_format_error
    elsif !in_range?(location, board_locations)
      out_of_range_location_error(location, board_locations)
    elsif !available_location?(location, available_locations)
      filled_location_error(location)
    end
  end

  def filled_location_error(location)
    <<-ERROR_MSG
      ERROR! The location #{location} is filled already.
      Please, select one of the available locations (marked by a number) ONLY.
    ERROR_MSG
  end

  def out_of_range_location_error(location, board_locations)
    <<~ERROR_MSG
      \tERROR! The location #{location} is out of range.
      \tPlease select a valid location - FROM #{board_locations.min} to #{board_locations.max} ONLY,\
        on screen, and which hasn't been selected yet.
    ERROR_MSG
  end

  def invalid_location_format_error
    <<-ERROR_MSG
      ERROR! The location's format is invalid.
      The location must be a positive, whole number, inside the given range.
    ERROR_MSG
  end

  # Board related Logic

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

  def convert_index_to_location(locations_map, grid_index)
    equivalent_location = nil

    locations_map.each do |location, index|
      equivalent_location = location if grid_index == index
    end

    equivalent_location
  end
end

# Don't mind the pieces of code bellow, i'm just testing the class
# as i go, to check if it's producing the desired behaviors/results

# I'll remove it once i'm done with the class, so if you you're in this
# commit, coming from a point where the class is already complete,
# don't mind the discrepancy, there's nothing important about it.

# board_locations = [1, 2, 3, 4, 5, 6, 7, 8, 9]
# available_locations = [1, 2, 3, 4, 5, 6, 7, 8]
# player_name = "p1"
# location = location.new(board_locations, available_locations, player_name).value

# p location
# puts location
# puts location.location
