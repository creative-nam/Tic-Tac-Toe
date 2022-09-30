class Board
  attr_reader :board_locations, :available_locations

  private
    attr_writer :board_locations, :available_locations

    attr_accessor :grid, :board_dimension, :amount_of_locations
  public

  def initialize(board_dimension)
    self.board_dimension = board_dimension
    self.amount_of_locations = board_dimension**2

    self.grid = Array.new(board_dimension) { Array.new(board_dimension) }
    populate_grid(amount_of_locations)

    self.board_locations = Hash.new(amount_of_locations)
    generate_locations(amount_of_locations)

    self.available_locations = board_locations.keys
  end

  def [](location)
    row, col = board_locations[location]

    grid[row][col]
  end

  def []=(location, player_symbol)
    row, col = board_locations[location]

    self.grid[row][col] = player_symbol

    update_available_locations(available_locations, location)
  end

  private

  def populate_grid(amount_of_locations)
    location_number = 1

    while location_number <= amount_of_locations do
      grid.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          self.grid[row_index][col_index] = location_number

          location_number += 1
        end
      end 
    end
  end

  def generate_locations(amount_of_locations)
    location = 1

    while location <= amount_of_locations do
      grid.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          self.board_locations[location] = [row_index, col_index]

          location += 1
        end
      end 
    end
  end

  def update_available_locations(available_locations, location_played)
    available_locations.delete(location_played)

    self.available_locations = available_locations
  end
end

# Don't the pieces of code bellow, i'm just testing the class
# as i go, to check if it's producing the desired behaviors/results

# I'll remove it once i'm done with the class, so if you you're in this
# commit, coming from a point where the class is already complete,
# don't mind the discrepancy, there's nothing important about it.
  
board = Board.new(5)
 
puts 'New game initiated.'

p board
  
    