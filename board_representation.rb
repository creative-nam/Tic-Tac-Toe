class BoardRepresentation
  attr_reader :representation

  private

  attr_writer :representation

  public

  def initialize(grid, smallest_location, highest_location)
    self.representation = generate_board_representation(grid, smallest_location, highest_location)
  end

  def generate_board_representation(grid, smallest_location, highest_location)
    board_representation = ''
    board_representation = break_line_and_indent(board_representation)

    current_location = smallest_location
    # The amount of digits the highest location (the last one) in the board will have
    max_location_digits = get_location_digits(highest_location)

    board_representation = separate_line(board_representation, grid.length, max_location_digits)

    grid.each do |row|
      board_representation = break_line_and_indent(board_representation, 2)

      row.each_with_index do |col, col_index|
        board_representation = add_whitespace_padding(board_representation, max_location_digits, col)
        board_representation += col.to_s
        board_representation = add_char_separator(board_representation) unless col_index == row.length - 1

        current_location += 1
      end

      board_representation = break_line_and_indent(board_representation, 2)
      board_representation = separate_line(board_representation, grid.length, max_location_digits)
    end

    board_representation
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
      # When we reach the last char in the line, we don't want
      # to add the separator_char, since it won't be "separating" any chars - it
      # feels outs place; just the trail_char is enough
      board_representation += last_char ? trail_char : lines_separation

      current_char += 1
    end

    board_representation
  end

  def add_whitespace_padding(board_representation, max_location_digits, grid_element)
    # The length difference is difference between the length or digits of the element (or
    # location) in the current grid_element, and the maximum amount of digits any element/location
    # will have.
    length_difference = max_location_digits - find_element_length(grid_element)
    length_difference.times { board_representation += ' ' }

    board_representation
  end

  def get_location_digits(location_number)
    (Math.log10(location_number) + 1).to_i
  end

  # Determines wether or not the a given element of the grid (a "square") has been "filled",
  # ie: selected/played by one of the players.
  # If its value is an integer, it hasn't been touched since we called populate_grid,
  # so we know it hasn't been selected. Otherwise, it'll be a string - the
  # symbol of the player which has selected it. And in that case, it has been filled.
  def element_filled?(grid_element)
    grid_element.instance_of?(String)
  end

  def find_element_length(grid_element)
    element_filled?(grid_element) ? grid_element.length : get_location_digits(grid_element)
  end
end
