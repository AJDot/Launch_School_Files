# 1. Guess Who is a 2 player game where each player tries to determine the other player's secret person. Each player has access to an identical list of people and their physical features. Players take turns narrowing down the possibilities by asking the other player a question regarding a physical feature. At anytime a player may guess the person's name and, if correct, the player wins.
# 2. Nouns and Verbs
#     * Nouns: player, list, secret person, features, question, guess
#     * Verbs: ask, guess
# 3. Guess at Organization
#     * Player
#       * ask
#       * guess
#     * List
# 4. A player will have a secret_person. A List can be used as a collaborator object for each person.

require 'pry'
require 'yaml'

module Formattable
  def title_case(string)
    string.split.map(&:capitalize).join(' ')
  end

  def to_trait_sym(string)
    string.to_s.gsub(/\s+/, '_').to_sym
  end

  def to_trait_string(string)
    string.to_s.gsub(/_/, ' ')
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def press_enter_to_continue
    puts "Press ENTER to continue..."
    gets
  end
end

class Person
  attr_reader :traits, :name

  def initialize(traits)
    @name = traits[:name]
    @traits = traits
  end

  def to_s
    name
  end

  def display_traits
    traits.values.each { |value| print value.center(10) }
    puts
  end

  def [](trait)
    traits[trait]
  end

  def size
    traits.keys.size
  end

  def has_trait?(trait, desc)
    traits[trait] == desc
  end

  def ==(other)
    name == other.name
  end
end

class List
  include Formattable

  attr_accessor :dosiers

  def initialize
    make_dosiers
  end

  def make_dosiers
    dosier_data = File.read "./guess_who_person_traits.yml"
    @dosiers = YAML::load dosier_data
    @dosiers.map! { |dosier| Person.new(dosier)}
  end

  def display
    dosiers.first.traits.keys.each do |key|
      value = to_trait_string(key)
      value = title_case(value)
      print value.center(10)
    end
    puts
    puts '-' * 10 * self[0].traits.size
    dosiers.each { |person| person.display_traits }
  end

  def size
    dosiers.size
  end

  def [](idx)
    dosiers[idx]
  end

  def []=(idx, value)
    dosiers[idx] = value
  end

  def first
    self[0]
  end

  def delete(person)
    dosiers.delete(person)
  end
end

class Player
  attr_reader :list, :secret_person

  def initialize(name)
    @list = List.new
    @name = name
    @secret_person = @list.dosiers.sample
  end

  def get_people(trait, desc, options)
    if options[:with] == true
      list.dosiers.select { |person| person[trait] == desc }
    else
      list.dosiers.select { |person| person[trait] != desc }
    end
  end

  def remove_people(trait, desc, options)
    get_people(trait, desc, options).each do |person|
      list.delete(person)
    end
  end

  def to_s
    @name.to_s
  end
end

class GuessWho
  include Formattable

  attr_reader :player1, :player2

  def initialize
    @player1 = Player.new("Alex")
    @player2 = Player.new("Jasmine")
  end

  def play
    clear_screen
    display_welcome_message
    press_enter_to_continue
    loop do
      clear_screen
      player1.list.display
      puts
      player1_ask
      break if player1_won?
      player2_ask
      break if player2_won?
    end
    display_result
    display_goodbye_message
  end

  private

  def player1_ask
    trait = nil
    desc = nil
    loop do
      puts "Guess a trait of player 2's secret person:"
      print "Trait: "
      trait = gets.chomp.strip
      trait = to_trait_sym(trait)
      print "Description: "
      desc = gets.chomp.capitalize.strip
      break unless player1.get_people(trait, desc, with: true).empty?
    end

    puts "You chose to check for #{trait}: #{desc}."
    if player2.get_people(trait, desc, with: true).include? player2.secret_person
      player1.remove_people(trait, desc, with: false)
    else
      player1.remove_people(trait, desc, with: true)
    end
  end

  def player2_ask

  end

  def player1_won?
    return unless player1.list.size == 1
    player1.list.first == player2.secret_person
  end

  def player2_won?
    return unless player2.list.size == 1
    player2.list.first == player1.secret_person
  end

  def display_welcome_message
    puts "Welcome to Guess Who!"
  end

  def display_result
    if player1_won?
      puts "You won!"
      puts "#{player2}'s secret person was #{player1.list.first}."
    else
      puts "#{player2} won!"
      puts "#{player1}'s secret person was #{player2.list.first}."
    end
  end

  def display_goodbye_message
    "Thank you for playing Guess Who! Goodbye!"
  end
end

game = GuessWho.new
game.play
