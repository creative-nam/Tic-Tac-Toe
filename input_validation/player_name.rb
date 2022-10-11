module PlayerName
  private

  def get_name(current_player, taken_name = nil)
    name = nil

    until name && valid_name?(name, taken_name)
      puts name_prompt_message(current_player, taken_name)
      name = gets.chomp

      unless valid_name?(name, taken_name)
        error_to_output = find_name_error(name, taken_name)
        puts error_to_output
      end
    end

    name
  end

  def valid_name?(name, taken_name)
    valid_name_chars?(name) && available_name?(name, taken_name)
  end

  def valid_name_chars?(name)
    # This is a regex that will match only alphanumerical chars
    # (including letters of any language) and underscores
    accepted_chars = /^\w+$/

    name.match?(accepted_chars)
  end

  def available_name?(name, taken_name)
    name != taken_name
  end

  def find_name_error(name, taken_name)
    available_name?(name, taken_name) ? invalid_name_chars_error : taken_name_error(name)
  end

  def invalid_name_chars_error
    <<-ERROR_MSG
      ERROR! Invalid name.
      Your name can only contain alphanumerical characters, and underscores.
    ERROR_MSG
  end

  def taken_name_error(name)
    <<-ERROR_MSG
      Error! Taken name.
      You cannot use the name "#{name}" because another player already chose it.
    ERROR_MSG
  end

  def name_prompt_message(current_player, taken_name)
    line_decorator = "\n"
    35.times { line_decorator += '-' }
    line_decorator += ' Choose your name '
    35.times { line_decorator += '-' } 

    taken_name_warning = "(Your name cannot be #{taken_name}, since it's taken.)"

    msg = <<~NAME_PROMPT_MSG
      #{line_decorator}
      Please enter Player #{current_player}'s name:#{' '}
    NAME_PROMPT_MSG

    taken_name ? msg + taken_name_warning : msg
  end
end
