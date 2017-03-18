# twenty_one.rb

# Game description
# This is essentially black jack but without all the complicated doubles
# and splits etc. Just a simple version where the player can 'hit' or 'stay'.

# High-level pseudo code
# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   3-1. ask 'hit' or 'stay'
#   3-2. if 'stay', stop asking
#   3-3. otherwise, go to #3-1
# 4. If player busts, then dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer busts, then player wins.
# 7. Compare cards and declare winner

# Program
require 'pry'

SUITS = %w(H D C S)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

def prompt(msg)
  puts "=> #{msg}"
end

def valid_input?(input, first_letter_of_valid_answers)
  first_letter_of_valid_answers.include?(input.downcase)
end

def initialize_deck
  deck = []
  SUITS.each { |suit| VALUES.each { |value| deck << [suit, value] }}
  deck
end

def shuffle_deck!(current_deck)
  current_deck.shuffle!
end

def deal_card!(current_deck, hand)
  # remove card from deck and add to player's hand
  hand << current_deck.shift
  # return will be the card itself
end

def initialize_hands!(current_deck, player1_hand, player2_hand)
  2.times do |_|
    deal_card!(current_deck, player1_hand)
    deal_card!(current_deck, player2_hand)
  end
end

def total(hand)
  values = hand.map { |card| card[1] }
  sum = 0
  values.each do |value|
    if %w(J Q K).include?(value)
      sum += 10
    elsif %w(1 2 3 4 5 6 7 8 9 10).include?(value)
      sum += value.to_i
    else # if the card is an Ace
      sum += 11
    end
  end

def make_card(card, rows, show_card=true)
  suit = case card[0]
         when 'S' then "\u2660"
         when 'H' then "\u2665"
         when 'D' then "\u2666"
         when 'C' then "\u2663"
         end
  value = card[1]

  if !show_card
    suit = '?'
    value = '?'
  end

  rows[0] += "----------- "
  rows[1] += "| #{value.ljust(3)} #{value.rjust(3)} | "
  rows[2] += "| #{suit}     #{suit} | "
  rows[3] += "|         | "
  rows[4] += "|   #{value.center(3)}   | "
  rows[5] += "|         | "
  rows[6] += "| #{suit}     #{suit} | "
  rows[7] += "| #{value.ljust(3)} #{value.rjust(3)} | "
  rows[8] += "----------- "

  rows
end

def display_cards(player_hand, dealer_hand, turn)
  system 'clear'
  player_rows = ['', '', '', '', '', '', '', '', '']
  dealer_rows = ['', '', '', '', '', '', '', '', '']
  if turn == 'player'
    player_hand.each do |card|
      player_rows = make_card(card, player_rows)
    end
    dealer_rows = make_card(dealer_hand[0], dealer_rows)
    dealer_rows = make_card(dealer_hand[0], dealer_rows, false)
  else # dealer's turn
    player_hand.each do |card|
      player_rows = make_card(card, player_rows)
    end
    dealer_hand.each do |card|
      dealer_rows = make_card(card, dealer_rows)
    end
  end
  puts "Your Cards: Total = #{total(player_hand)}"
  puts player_rows
  puts "Dealer's Cards: Total = #{turn == 'player' ? "??" : total(dealer_hand)}"
  puts dealer_rows

end


  # correct for Aces
  values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end

def busted?(hand)
  total(hand) > 21
end

def hit?(hand)
  total(hand) < 17
end

def decide_winner(player1_hand, player2_hand)
  if total(player1_hand) >= total(player2_hand)
    'player'
  else total(player2_hand) > total(player1_hand)
    'dealer'
  end
end

def display_winner(winning_player)
  if winning_player == 'player'
    prompt "Congratulations! You won!"
  else
    prompt "You lose! The dealer out-played you!"
  end
end

def play_again?
  answer = nil
  loop do
    prompt "Would you like to play again? (y or n)"
    answer = gets.chomp
    break if valid_input?(answer, %w(y n))
    prompt "That is not a valid choice."
  end
  answer.downcase.start_with?('y') ? true : false
end

loop do # Game loop
  system 'clear'
  # Start game
  deck = initialize_deck
  shuffle_deck!(deck)

  # Deal cards
  player_hand = []
  dealer_hand = []
  initialize_hands!(deck, player_hand, dealer_hand)


  player_total = total(player_hand)
  dealer_total = total(dealer_hand)

  turn = 'player'
  # Player turn
  loop do
    display_cards(player_hand, dealer_hand, turn)
    answer = nil
    loop do # get 'hit' or 'stay' from player
      puts "hit or stay"
      answer = gets.chomp
      break if valid_input?(answer, %w(h s))
      prompt "That is not a valid choice."
    end

    deal_card!(deck, player_hand) if answer.downcase.start_with?('h')

    break if valid_input?(answer, %w(s)) || busted?(player_hand)
  end

  answer = nil
  if busted?(player_hand)
    display_cards(player_hand, dealer_hand, turn)
    prompt "You busted!"
    prompt "The dealer won!"

    # if yes, go back to the top to start the game over
    # if no, break the loop to exit the game
    play_again? ? next : break
  else
    prompt "You chose to stay!"
  end

  # Dealer turn
  loop do
    turn = 'dealer'
    display_cards(player_hand, dealer_hand, turn)
    break if busted?(dealer_hand) || !hit?(dealer_hand)

    prompt "The dealer chose to hit!"
    sleep(2)
    deal_card!(deck, dealer_hand)
  end

  # if dealer does not draw another card
  if busted?(dealer_hand)
    prompt "The dealer busted!"
    prompt "You win!"
  else # dealer stayed - declare winner
    prompt "The dealer chose to stay!"
    winner = decide_winner(player_hand, dealer_hand)
    display_winner(winner)
  end

  break unless play_again?
end

prompt "Thanks for playing Twenty-One! Good bye!"
