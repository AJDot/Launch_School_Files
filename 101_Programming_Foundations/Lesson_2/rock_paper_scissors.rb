VALID_CHOICES = %w(rock paper scissors lizard Spock)
letter_to_word = {}
VALID_CHOICES.each_with_index do |word, index|
  letter = word[0]
  letter_to_word[letter] = word
end
puts letter_to_word.inspect


def prompt(message)
  Kernel.puts("=> #{message}")
end


def win?(first, second)
  # Defining winning situations in this way allows you to change the
  # choices to whatever you want.
  [[VALID_CHOICES[2] , VALID_CHOICES[1]],
    [VALID_CHOICES[1] , VALID_CHOICES[0]],
    [VALID_CHOICES[0] , VALID_CHOICES[3]],
    [VALID_CHOICES[3] , VALID_CHOICES[4]],
    [VALID_CHOICES[4] , VALID_CHOICES[2]],
    [VALID_CHOICES[2] , VALID_CHOICES[3]],
    [VALID_CHOICES[3] , VALID_CHOICES[1]],
    [VALID_CHOICES[1] , VALID_CHOICES[4]],
    [VALID_CHOICES[4] , VALID_CHOICES[0]],
    [VALID_CHOICES[0] , VALID_CHOICES[2]]
  ].include?([first, second])
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

loop do # main loop
  choice = ''
  loop do # user choice lopo
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("Input first letter to make selection.")
    letter_choice = Kernel.gets().chomp()

    # If the letter is in the choice hash, select it
    # elsif the downcase of letter is in hash, select it
    # else return empty string
    choice =  if letter_to_word.has_key?(letter_choice)
                letter_to_word[letter_choice]
              elsif letter_to_word.has_key?(letter_choice.swapcase)
                letter_to_word[letter_choice.swapcase]
              else
                ''
              end

    break unless choice == '' # break if valid choice was made
    prompt("That's not a valid choice.")
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for playing. Good bye!")
