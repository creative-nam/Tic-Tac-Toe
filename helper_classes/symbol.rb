class Symbol
  private

  attr_accessor :player_name, :taken_symbol, :symbol

  public

  @@accepted_special_chars = ['<', '>', '&', '+', '=', '?', '@', '#']

  def initialize(player_name, taken_symbol = nil)
    self.player_name = player_name
    self.taken_symbol = taken_symbol

    self.symbol = get_symbol(player_name)
  end

  def value
    symbol
  end

  private

  def get_symbol(player_name, taken_symbol)
    user_input = nil

    until user_input && valid?(user_input)
      puts ''
      10.times { print '---' }
      puts ''

      puts "#{player_name}, please enter a single, alphabetic character as your symbol:"
      puts "(Your symbol cannot be #{taken_symbol}, since it's taken)" if taken_symbol

      user_input = gets.chomp

      puts find_error(user_input) unless valid?(user_input)
    end

    user_input
  end

  def valid?(symbol)
    valid_length?(symbol) && valid_char?(symbol) && !taken?(symbol)
  end

  def valid_length?(symbol)
    symbol.length == 1
  end

  def valid_char?(symbol)
    alpha_regex = /\A[[:alpha:]]+\z/i

    alpha_regex.match?(symbol) || @@accepted_special_chars.include?(symbol)
  end

  def taken?(symbol)
    symbol == @@taken_symbol
  end

  def find_symbol_error(symbol)
    if !valid_length?(symbol)
      invalid_length_error
    elsif !valid_char?(symbol)
      invalid_char_error
    elsif taken?(symbol)
      taken_symbol_error(symbol)
    end
  end

  def invalid_length_error
    <<-ERROR_MSG
      ERROR! Invalid symbol length.
      Your symbol cannot be more than ONE character.
    ERROR_MSG
  end

  def invalid_char_error
    <<-ERROR_MSG
      ERROR! Invalid symbol character.
      Your symbol must be letter an alphabetic character, or one of the\
      following special characters: #{@@accepted_special_chars}#{' '}
    ERROR_MSG
  end

  def taken_symbol_error(symbol)
    <<-ERROR_MSG
      Error! Taken symbol.
      You cannot use the symbol "#{symbol}" because another player already chose it.
    ERROR_MSG
  end
end
