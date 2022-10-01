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

  def display_grid
    puts generate_grid_output(amount_of_locations)
  end

  def get_location_digits(location_number)
    (Math.log10(location_number) + 1).to_i
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

  def generate_grid_output(amount_of_locations)
    grid_output = ''
    
    # We want to know the amount of digits a certain number has so that we can add
    # underscores bellow our location number accordingly, so as to avoid having a
    # disproportionate amount of underscores between lines; which would make 
    # our board... ugly.
    # 
    # ie: if max number of digits we'll have in a number in the board is 4 (eg, 1000)
    # we want all of our numbers, starting from 1, to have 4 underscores under them.

    max_location_digits = get_location_digits(amount_of_locations)

    underscores = ''
    max_location_digits.times { underscores += '_' }

    # The underscores should only cover the number in the above line, so followed
    # by it (between underscores), we have 5 spaces, which are there to match the 
    # 2 spaces + "|" + 2 spaces, in the line above.
    # Essentially, we want whitespace in the areas which don't contain a number in
    # the line above.
    
    space_between_numbers = ' ' + ' ' + ' ' + ' ' + ' '
    lines_separation = underscores + space_between_numbers

    grid_output += "\t"
    grid.length.times { grid_output += lines_separation }

    current_location_number = board_locations.keys.min

    grid.each_with_index do |row, row_index|
      grid_output += "\n" + "\t" + "\n" + "\t"

      row.each_with_index do |_col, col_index|
        current_square = grid[row_index][col_index]

        # Throughout our game, there are going to be two possibilities for the
        # value each "square" in the grid contains:
        # 1 - The square's has already been filled; its has been played/selected
        # by one of the players. Its value is currently a string (the symbol of the 
        # player who chose that square/location).
        # 2 - The square hasn't been filled; its hasn't been played/selected yet, 
        # and its current value is a number (the one assigned to it by the populate_grid method).

        # If it is a number, we want to know how many digits that number has.

        # If it is a string, we want to know the length of the string.

        # After we have either of those values, we want to compare it max_location_digits; if
        # it's smaller than max_location digits, it should have some whitespace before it 
        # to compensate for the missing characters.
        # The amount of whitespace chars to fill that gap, would be the difference between 
        # max_location_digits and the length of the string or the digits of the number 
        # (whichever one we have).

        if current_square.class == Integer
          current_location_digits = get_location_digits(current_location_number)
        elsif current_square.class == String
          current_square_length = current_square.length
        end

        if (current_location_digits or current_square_length) < max_location_digits
          length_difference = max_location_digits - (current_location_digits or current_square_length)
          
          length_difference.times { grid_output += ' ' }
        end

        grid_output += "#{current_square}"
        grid_output +=  ' ' + ' ' + '|' + ' ' + ' ' unless col_index == row.length - 1

        current_location_number += 1
      end

      grid_output += "\n" + "\t"
      grid.length.times { grid_output += lines_separation }
    end

    grid_output
  end
end

# Don't mind the pieces of code bellow, i'm just testing the class
# as i go, to check if it's producing the desired behaviors/results

# I'll remove it once i'm done with the class, so if you you're in this
# commit, coming from a point where the class is already complete,
# don't mind the discrepancy, there's nothing important about it.
  
board = Board.new(5)
 
puts 'New game initiated.'; puts ''

board.display_grid

board[1] = 'X'
board[6] = 'X'
board[11] = 'X'
board[16] = 'X'


puts 'New board'; puts ''

10.times { print '=' }; puts ''

board.display_grid
  
    