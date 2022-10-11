module BoardDimension
  private

  @@minimum_accepted_dimension = 3
  @@maximum_accepted_dimension = 100

  def get_dimension
    dimension = nil

    until dimension && valid_dimension?(dimension)
      puts dimension_prompt_message
      dimension = gets.chomp

      unless valid_dimension?(dimension)
        error_to_output = find_dimension_error(dimension)
        puts error_to_output
      end
    end

    dimension.to_i
  end

  def dimension_in_range?(dimension)
    dimension.to_i.between?(@@minimum_accepted_dimension, @@maximum_accepted_dimension)
  end

  def valid_dimension_format?(dimension)
    return true if dimension == '0'

    dimension == dimension.to_i.to_s
  end

  def find_dimension_error(dimension)
    dimension_in_range?(dimension) ? invalid_dimension_format_error : out_of_range_dimension_error(dimension)
  end

  def valid_dimension?(dimension)
    valid_dimension_format?(dimension) && dimension_in_range?(dimension)
  end

  def invalid_dimension_format_error
    <<-ERROR_MSG
      ERROR! The dimension's format is invalid.
      The dimension must be a positive, whole number, inside the given range.
    ERROR_MSG
  end

  def out_of_range_dimension_error(dimension)
    <<~ERROR_MSG
      \tERROR! The dimension #{dimension} is out of range.
      \tPlease select a valid dimension - FROM #{@@minimum_accepted_dimension} to \
      #{@@maximum_accepted_dimension} ONLY.
    ERROR_MSG
  end

  def dimension_prompt_message
    line_decorator = "\n"
    30.times { line_decorator += '-' }
    line_decorator += ' Choose the Board\'s dimension '
    30.times { line_decorator += '-' }

    <<~PROMPT_MSG
      #{line_decorator}
      Please enter the dimension of the board you would like to play in.
      (The dimension can be a number from #{@@minimum_accepted_dimension} to \
      #{@@maximum_accepted_dimension}.)

      The board you'll play in will be a 'n x n' grid, with n being your chosen dimension.
    PROMPT_MSG
  end
end
