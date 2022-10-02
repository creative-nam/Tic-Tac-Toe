class Name
  private

  attr_accessor :current_player, :taken_name, :name

  public

  def initialize(current_player = 1, taken_name = nil)
    self.current_player = current_player
    self.taken_name = name

    self.name = get_name(taken_name)
  end

  def value
    name
  end

  private

  def get_name(taken_name = nil)
    user_input = nil

    until user_input && valid?(user_input)
      puts ''
      10.times { print '---' }
      puts ''

      puts "Please enter Player #{current_player}'s name: "
      puts "(Your name cannot be #{taken_name}, since it's taken.)" if taken_name

      user_input = gets.chomp

      puts find_error(user_input) unless valid?(user_input)
    end
    user_input
  end

  def valid?(name)
    valid_chars?(name) && !taken?(name)
  end

  def valid_chars?(name)
    # This is a regex that will match only alphanumerical chars
    # (including letters of any language) and underscores
    accepted_chars = /^\w+$/

    name.match?(accepted_chars)
  end

  def taken?(name)
    name == taken_name
  end

  def find_error(name)
    taken?(name) ? taken_name_error(name) : invalid_chars_error
  end

  def invalid_chars_error
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
end
