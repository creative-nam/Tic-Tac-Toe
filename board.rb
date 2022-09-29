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
  
      self.board_locations = Hash.new(amount_of_locations)
  
      self.available_locations = board_locations.keys
    end
  
    def [](location)
      row, col = board_locations[location]
  
      grid[row][col]
    end
  
    def []=(location, player_symbol)
      row, col = board_locations[location]
  
      self.grid[row][col] = player_symbol
  
      update_available_positions(available_locations, location)
    end
  
    private
  
    def update_available_positions(available_locations, location_played)
      available_locations.delete(location_played)
  
      self.available_locations = available_locations
    end
  end
  
  board = Board.new(10)
  
  puts 'New game initiated.'
  
  
    