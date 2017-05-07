# class GuessingGame
#   MAX_GUESSES = 7
#   RANGE = 1..100
#
#   HINT = {
#     low: 'Your number is too low.',
#     high: 'Your number is too high.',
#     match: "That's the number!"
#   }.freeze
#
#   RESULT_OF_GAME_MESSAGE = {
#     high: 'You have no more guesses. You lost!',
#     low: 'You have no more guesses. You lost!',
#     match: 'You won!'
#   }
#
#   def initialize
#     @secret_number = nil
#   end
#
#   def play
#     reset
#     result = nil
#     MAX_GUESSES.downto(1) do |guesses_remaining|
#       display_guesses_remaining(guesses_remaining)
#       result = check_guess(player_guess)
#       puts HINT[result], ''
#       break if result == :match
#     end
#     display_end_game_message(result)
#   end
#
#   private
#
#   def display_guesses_remaining(remaining)
#     if remaining == 1
#       puts 'You have 1 guess remaining.'
#     else
#       puts "You have #{remaining} guesses remaining."
#     end
#   end
#
#   def player_guess
#     guess = nil
#     loop do
#       print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
#       guess = gets.chomp.to_i
#       break if RANGE.cover? guess
#       print 'Invalid guess. '
#     end
#     guess
#   end
#
#   def check_guess(guess)
#     return :match if guess == @secret_number
#     return :low if guess < @secret_number
#     :high
#   end
#
#   def display_end_game_message(result)
#     puts RESULT_OF_GAME_MESSAGE[result], ''
#   end
#
#   def reset
#     @secret_number = rand(RANGE)
#   end
# end

# game = GuessingGame.new
# game.play
# game.play

puts 'FURTHER EXPLORATION'

module SecretRange
  RANGE = 1..100
end

class Player
  include SecretRange

  def make_guess
    guess = nil
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      break if RANGE.cover? guess
      print 'Invalid guess. '
    end
    guess
  end
end

class GuessingGame
  include SecretRange
  MAX_GUESSES = 7

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

  def initialize
    @guesses_remaining = MAX_GUESSES
    @secret_number = nil
    @player = Player.new
  end

  def play
    reset
    result = nil
    MAX_GUESSES.downto(1) do |guesses_remaining|
      display_guesses_remaining(guesses_remaining)
      result = check_guess(@player.make_guess)
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

  def check_guess(guess)
    return :match if guess == @secret_number
    return :low if guess < @secret_number
    :high
  end

  def display_end_game_message(result)
    puts RESULT_OF_GAME_MESSAGE[result], ''
  end

  def reset
    @secret_number = rand(RANGE)
  end
end

game = GuessingGame.new
game.play
game.play
