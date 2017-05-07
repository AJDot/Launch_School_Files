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

require 'pry'

class PokerHand

  def self.init(hand)
    @hand = hand
    @rank_count = Hash.new(0)
    @hand.each { |card| @rank_count[card.rank] += 1 }
  end

  def self.royal_flush?(hand)
    init(hand)
    straight_flush?(hand) && @hand.min.rank == 10
  end

  def self.straight_flush?(hand)
    init(hand)
    straight?(hand) && flush?(hand)
  end

  def self.four_of_a_kind?(hand)
    init(hand)
    n_of_a_kind?(4)
  end

  def self.full_house?(hand)
    init(hand)
    three_of_a_kind?(hand) && pair?(hand)
  end

  def self.flush?(hand)
    init(hand)
    suit = @hand.first.suit
    @hand.all? { |card| card.suit == suit }
  end

  def self.straight?(hand)
    init(hand)
    return false if @rank_count.any? { |_, count| count > 1 }

    @hand.min.value == @hand.max.value - 4
  end

  def self.three_of_a_kind?(hand)
    init(hand)
    n_of_a_kind?(3)
  end

  def self.two_pair?(hand)
    init(hand)
    @rank_count.select { |_, count| count ==2 }.size == 2
  end

  def self.pair?(hand)
    init(hand)
    n_of_a_kind?(2)
  end

  def self.high_card?(hand)
    init(hand)
    !pair?(hand) &&
    !three_of_a_kind?(hand) &&
    !four_of_a_kind?(hand) &&
    !straight?(hand) &&
    !flush?(hand)
  end

  private

  def self.n_of_a_kind?(number)
    @rank_count.one? { |_, count| count == number }
  end
end

class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
puts PokerHand.royal_flush?([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
]) # => true

puts PokerHand.straight_flush?([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
]) # => true

puts PokerHand.four_of_a_kind?([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
]) # => true
#
puts PokerHand.full_house?([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
]) # => true

puts PokerHand.flush?([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
]) # => true

puts PokerHand.straight?([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
]) # => true

puts PokerHand.three_of_a_kind?([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
]) # => true
#
puts PokerHand.two_pair?([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
]) # => true

puts PokerHand.pair?([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
]) # => true

puts PokerHand.high_card?([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
]) # => true
