# Twenty-One is a card game consisting of a dealer and a player, where the participants tr tp get as close to 21 as possible without going over.
# Overview:
# - Both participants are initially dealt 2 cards from a 52-card deck.
# - The player takes the first turn, and can "hit" or "stay".
# - If the player busts, he loses. If he stays, it's the dealer's turn.
# - The dealer must hit until his cards add up to at least 17.
# - If he busts, the player wins. If both player and dealer stays, then the highest total wins.
# - If both totals are equals, then it's a tie, and nobody wins.

# Nouns: card, player, dealer, deck, game, totals
# Verbs: deal, bust, stay, hit

# can actually think of total as a verb "calculate_total"
# "bust" is not an action any performs. It is a state, "busted?"

# Classes and Methods
# Player
# - hit
# - stay
# - busted?
# - total
# Dealer
# - hit
# - stay
# - busted?
# - total
# - deal (should this be here, or in Deck?)
# Participant (superclass of Player and Dealer?)
# Deck
# - deal (should this be here, or in Deck?)
# Card
# Game
# - start

# Spike
class Card
  SUITS = %w(C H S D)
  VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  def initialize(suit, face)
    @suit = suit
    @face = face
    # what are the "states" of a card?
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else @face
    end
  end

  def to_s
    "The #{face} of #{suit}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    # obviously, we need some data structure to keep track of cards
    # array, hash, something else? (I think array)
    @cards = setup_cards
    shuffle_cards
  end

  def setup_cards
    Card::SUITS.product(Card::VALUES).map do |suit, face| Card.new(suit, face)
    end
  end

  def deal_card
    cards.shift
  end

  def shuffle_cards
    cards.shuffle!
  end
end

module Hand
  def add_card(new_card)
    cards << new_card
  end

  def show_hand
    puts "----- #{name}'s Hand -----"
    cards.each { |card| puts "=> #{card}" }
    puts ""
  end
end

class Participant
  include Hand

  attr_accessor :cards, :name

  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
  def set_name
    @name = 'Player'
  end

  def show_flop
    show_hand
  end

  def hit

  end

  def stay

  end

  def busted?

  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Dealer < Participant
  def set_name
    @name = 'Dealer'
  end

  def show_flop
    puts "----- #{name}'s Hand -----"
    puts "=> #{cards.first}"
    puts "=> ??"
    puts ""
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    # what's the sequence of steps to execute the game play?
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_card)
      dealer.add_card(deck.deal_card)
    end
  end

  def show_initial_cards
    player.show_flop
    dealer.show_flop
  end

  def player_turn

  end

  def dealer_turn

  end

  def show_result

  end


end

Game.new.start
