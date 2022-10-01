class Position
  private
    attr_accessor :board_location, :available_location, :location
  public
  
  def initialize(board_location, available_location, player_name)
    self.board_location = board_location
    self.available_location = available_location
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
    board_location.include?(location)
  end

  def available?(location)
    available_location.include?(location)
  end

  def valid?(location)
    in_range?(location) && available?(location) && valid_format?(location, location)
  end
end

# board_location = [1, 2, 3, 4, 5, 6, 7, 8, 9]
# available_location = [1, 2, 3, 4, 5, 6, 7, 8]
# player_name = "p1"
# location = location.new(board_location, available_location, player_name).value

# p location
# puts location
# puts location.location
