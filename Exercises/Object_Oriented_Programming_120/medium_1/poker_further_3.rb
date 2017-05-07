class Card
  include Comparable

  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    self.value <=> other.value
  end

  def value
    VALUES.fetch(@rank, @rank)
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map { |rank, suit| Card.new(rank, suit) }
    @deck.shuffle!
  end
end

class PokerHand

  HAND_RANKS = {
    'Royal flush' => 10,
    'Straight flush' => 9,
    'Four of a kind' => 8,
    'Full house' => 7,
    'Flush' => 6,
    'Straight' => 5,
    'Three of a kind' => 4,
    'Two pair' => 3,
    'Pair' => 2,
    'High card' => 1,
  }

  def initialize(deck)
    @hand = []
    7.times do
      card = deck.draw
      @hand << card
    end
  end

  def print
    puts @hand
  end

  def evaluate
    hand_outcomes.max_by { |outcome| HAND_RANKS[outcome] }
  end

  private

  def evaluate_one_hand
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  def hand_outcomes
    all_hands.map do |hand|
      @rank_count = Hash.new(0)
      @cards = hand
      @cards.each { |card| @rank_count[card.rank] += 1 }
      evaluate_one_hand
    end
  end

  def all_hands
    @hand.combination(5).to_a
  end

  def royal_flush?
    straight_flush? && @cards.min.rank == 10
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    suit = @cards.first.suit
    @cards.all? { |card| card.suit == suit }
  end

  def straight?
    return false if @rank_count.any? { |_, count| count > 1 }

    @cards.min.value == @cards.max.value - 4
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    @rank_count.select { |_, count| count ==2 }.size == 2
  end

  def pair?
    n_of_a_kind?(2)
  end

  def n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end
end

class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts'),
  Card.new(5,       'Hearts'),
  Card.new('Queen', 'Clubs')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds'),
  Card.new(5, 'Hearts'),
  Card.new(4, 'Spades')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(7, 'Hearts')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts'),
  Card.new(4, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds'),
  Card.new(10,      'Spades'),
  Card.new(8,      'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds'),
  Card.new(4, 'Clubs'),
  Card.new(7, 'Diamonds')
])
puts hand.evaluate == 'High card'
