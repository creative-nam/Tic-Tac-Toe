module PlayerSymbol
  @@accepted_special_chars = ['<', '>', '&', '+', '=', '?', '@', '#']

  private

  def get_symbol(player_name, taken_symbol)
    symbol = nil

    until symbol && valid_symbol?(symbol, taken_symbol)
      puts symbol_prompt_message(player_name, taken_symbol)
      symbol = gets.chomp

      error_to_output = find_symbol_error(symbol, taken_symbol) and puts error_to_output
    end

    symbol
  end

  def valid_symbol?(symbol, taken_symbol)
    valid_length?(symbol) && valid_char?(symbol) && available_symbol?(symbol, taken_symbol)
  end

  def valid_length?(symbol)
    symbol.length == 1
  end

  def valid_char?(symbol)
    alpha_regex = /\A[[:alpha:]]+\z/i

    alpha_regex.match?(symbol) || @@accepted_special_chars.include?(symbol)
  end

  def available_symbol?(symbol, taken_symbol)
    symbol != taken_symbol
  end

  def find_symbol_error(symbol, taken_symbol)
    if !valid_length?(symbol)
      invalid_length_error
    elsif !valid_char?(symbol)
      invalid_char_error
    elsif !available_symbol?(symbol, taken_symbol)
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
    <<~ERROR_MSG
      \tERROR! Invalid symbol character.
      \tYour symbol must be letter an alphabetic character, or one of the \
      following special characters: #{@@accepted_special_chars}.
    ERROR_MSG
  end

  def taken_symbol_error(symbol)
    <<-ERROR_MSG
      Error! Taken symbol.
      You cannot use the symbol "#{symbol}" because another player already chose it.
    ERROR_MSG
  end

  def symbol_prompt_message(player_name, taken_symbol)
    line_decorator = "\n"
    35.times { line_decorator += '-' }
    line_decorator += ' Choose your symbol '
    35.times { line_decorator += '-' }

    taken_symbol_warning = "(Your symbol cannot be #{taken_symbol}, since it's taken)"

    msg = <<~SYMBOL_PROMPT_MSG
      #{line_decorator}
      #{player_name}, please enter a single character as your symbol:
      (Your symbol can be a letter, or one of the following special \
      characters: #{@@accepted_special_chars})
    SYMBOL_PROMPT_MSG

    taken_symbol ? msg + taken_symbol_warning : msg
  end
end
