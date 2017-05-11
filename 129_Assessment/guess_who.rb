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
end

class List
  attr_accessor :dosier

  def initialize
    @dosier = [
      Person.new({name: 'Alex', bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Black', hat: 'No', moustache: 'Yes', nose: "Small"}),
      Person.new({name: "Alfred", bald: 'No', beard: 'No', eye_color: 'Blue', gender: 'Male', glasses: 'No', hair_color: 'Red', hat: 'No', moustache: 'Yes', nose: "Small"}),
      Person.new({name: "Anita", bald: 'No', beard: 'No', eye_color: 'Blue', gender: 'Female', glasses: 'No', hair_color: 'Blonde', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Anne", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Female', glasses: 'No', hair_color: 'Black', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Bernard", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Brown', hat: 'Yes', moustache: 'No', nose: "Large"}),
      Person.new({name: "Bill", bald: 'Yes', beard: 'Yes', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Red', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Charles", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Blonde', hat: 'No', moustache: 'Yes', nose: "Small"}),
      Person.new({name: "Claire", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Female', glasses: 'Yes', hair_color: 'Red', hat: 'Yes', moustache: 'No', nose: "Small"}),
      Person.new({name: "David", bald: 'No', beard: 'Yes', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Blonde', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Eric", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Blonde', hat: 'Yes', moustache: 'No', nose: "Small"}),
      Person.new({name: "Frans", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Red', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "George", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'White', hat: 'Yes', moustache: 'No', nose: "Small"}),
      Person.new({name: "Herman", bald: 'Yes', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Red', hat: 'No', moustache: 'No', nose: "Large"}),
      Person.new({name: "Joe", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'Yes', hair_color: 'Blonde', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Maria", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Female', glasses: 'No', hair_color: 'Brown', hat: 'Yes', moustache: 'No', nose: "Small"}),
      Person.new({name: "Max", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Black', hat: 'No', moustache: 'Yes', nose: "Large"}),
      Person.new({name: "Paul", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'Yes', hair_color: 'White', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Peter", bald: 'No', beard: 'No', eye_color: 'Blue', gender: 'Male', glasses: 'No', hair_color: 'White', hat: 'No', moustache: 'No', nose: "Large"}),
      Person.new({name: "Philip", bald: 'No', beard: 'Yes', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Black', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Richard", bald: 'Yes', beard: 'Yes', eye_color: 'Brown', gender: 'Male', glasses: 'No', hair_color: 'Brown', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Robert", bald: 'No', beard: 'No', eye_color: 'Blue', gender: 'Male', glasses: 'No', hair_color: 'Brown', hat: 'No', moustache: 'No', nose: "Large"}),
      Person.new({name: "Sam", bald: 'Yes', beard: 'No', eye_color: 'Brown', gender: 'Male', glasses: 'Yes', hair_color: 'White', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Susan", bald: 'No', beard: 'No', eye_color: 'Brown', gender: 'Female', glasses: 'No', hair_color: 'White', hat: 'No', moustache: 'No', nose: "Small"}),
      Person.new({name: "Tom", bald: 'Yes', beard: 'No', eye_color: 'Blue', gender: 'Male', glasses: 'Yes', hair_color: 'Black', hat: 'No', moustache: 'No', nose: "Small"})
      ]
  end

  def display
    # display all people left and their traits
    # binding.pry
    @dosier.first.traits.keys.each do |key|
      value = key.to_s.gsub(/_/, ' ').split.map(&:capitalize).join(' ')
      print value.to_s.center(10)
    end
    puts
    puts '-' * 10 * @dosier.first.traits.keys.size
    @dosier.each { |person| person.display_traits }
  end

  def size
    @dosier.size
  end

  def [](idx)
    @dosier[idx]
  end

  def []=(idx, value)
    @dosier[idx] = value
  end

  def first
    self[0]
  end
end

class Player
  attr_reader :list, :secret_person

  def initialize(name)

    @list = List.new
    @name = name
    @secret_person = @list.dosier.sample

  end

  def get_people_with_trait(trait, desc)
    @list.dosier.select do |person|
      person.traits[trait] == desc
    end
  end

  def get_people_without_trait(trait, desc)
    @list.dosier.select do |person|
      person.traits[trait] != desc
    end
  end

  def remove_people_with_trait(trait, desc)
    get_people_with_trait(trait, desc).each do |person|
      list.dosier.delete(person)
    end
  end

  def remove_people_without_trait(trait, desc)
    get_people_without_trait(trait, desc).each do |person|
      list.dosier.delete(person)
    end
  end

  def to_s
    @name.to_s
  end

end

class GuessWho
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
      system('clear')
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
      trait.gsub!(/\s+/, '_')
      trait = trait.to_sym
      print "Description: "
      desc = gets.chomp.capitalize.strip
      break unless player1.get_people_with_trait(trait, desc).empty?
    end

    puts "You chose to check for #{trait}: #{desc}."
    if player2.get_people_with_trait(trait, desc).include? player2.secret_person
      player1.remove_people_without_trait(trait, desc)
    else
      player1.remove_people_with_trait(trait, desc)
    end
  end

  def player1_won?
    player1.list.size == 1
  end

  def player2_won?
    player2.list.size == 1
  end

  def display_welcome_message
    puts "Welcome to Guess Who!"
  end

  def display_result
    if player1_won?
      puts "You won!"
      puts "#{player2}'s secret person was #{player1.list.first}."
    end
  end

  def display_goodbye_message
    "Thank you for playing Guess Who! Goodbye!"
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def press_enter_to_continue
    puts "Press ENTER to continue..."
    gets
  end
end

game = GuessWho.new
game.play