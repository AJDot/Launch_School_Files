class Card
  include Comparable

  attr_reader :rank, :suit

  RANK_VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  SUIT_VALUES = { 'Spades' => 4, 'Hearts' => 3, 'Clubs' => 2, 'Diamonds' => 1 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    if self.rank_value == other.rank_value
      self.suit_value <=> other.suit_value
    else
      self.rank_value <=> other.rank_value
    end
  end

  def rank_value
    RANK_VALUES.fetch(@rank, @rank)
  end

  def suit_value
    SUIT_VALUES.fetch(@suit)
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end

cards = [Card.new(4, 'Hearts'),
         Card.new(4, 'Diamonds'),
         Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.min == Card.new(4, 'Diamonds')

cards = [Card.new(2, 'Hearts'),
         Card.new('Ace', 'Diamonds'),
         Card.new('Ace', 'Clubs')]
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max == Card.new('Jack', 'Spades')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min == Card.new(8, 'Diamonds')
puts cards.max == Card.new(8, 'Spades')
