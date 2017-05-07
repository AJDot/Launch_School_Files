class GuessingGame
  HINT = {
    low: 'Your number is too low.',
    high: 'Your number is too high.',
    match: "That's the number!"
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    high: 'You have no more guesses. You lost!',
    low: 'You have no more guesses. You lost!',
    match: 'You won!'
  }

  def initialize(low, high)
    @max_guesses = Math.log2(high - low + 1).to_i + 1
    @secret_number = nil
    @range = low..high
  end

  def play
    reset
    result = nil
    @max_guesses.downto(1) do |guesses_remaining|
      display_guesses_remaining(guesses_remaining)
      result = check_guess(player_guess)
      puts HINT[result], ''
      break if result == :match
    end
    display_end_game_message(result)
  end

  private

  def display_guesses_remaining(remaining)
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def player_guess
    guess = nil
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      guess = gets.chomp.to_i
      break if @range.cover? guess
      print 'Invalid guess. '
    end
    guess
  end

  def check_guess(guess)
    return :match if guess == @secret_number
    return :low if guess < @secret_number
    :high
  end

  def display_end_game_message(result)
    puts RESULT_OF_GAME_MESSAGE[result], ''
  end

  def reset
    @secret_number = rand(@range)
  end
end

game = GuessingGame.new(501, 1500)
game.play
game.play
