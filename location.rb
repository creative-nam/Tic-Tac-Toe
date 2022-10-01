class Location
  private
    attr_accessor :board_locations, :available_locations, :location
  public
  
  def initialize(board_locations, available_locations, player_name)
    self.board_locations = board_locations
    self.available_locations = available_locations
  end

  def value
    location
  end

  private

  # Here we're trying to find out if the location the user inputted is
  # indeed a number (as it should be). 
  # So to do that, we'll attempt to convert that location from a string
  # (returned by the gets method) to an int. If the location is indeed
  # a number, to_i will return it as an int; otherwise it'll return 0.

  # An edge case would be if the location is "0". So we'll check directly
  # for that directly.
  
  def valid_format?(location)
    return true if location == "0"

    location == location.to_i.to_s
  end

  def in_range?(location)
    board_locations.include?(location.to_i)
  end

  def available?(location)
    available_locations.include?(location.to_i)
  end

  def valid?(location)
    valid_format?(location) && in_range?(location) && available?(location) 
  end

  def find_error(location)
    case
    when !valid_format?(location) then invalid_format_error
    when !in_range?(location) then out_of_range_location_error(location)
    when !available?(location) then filled_location_error(location)
    end
  end
  
  def filled_location_error(location)
    <<-EOS
      ERROR! The location #{location} is filled already.
      Please, select one of the available locations (marked by a number) ONLY.
    EOS
  end
  
  def out_of_range_location_error(location)
    <<~EOS
      \t  ERROR! The location #{location} is out of range.
      \t  Please select a valid location - FROM #{board_locations.min} to #{board_locations.max} ONLY,\
          on screen, and which hasn't been selected yet.
    EOS
  end
  
  def invalid_format_error
    <<-EOS
      ERROR! The location's format is invalid.
      The location must be a positive, whole number, inside the given range.
    EOS
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
