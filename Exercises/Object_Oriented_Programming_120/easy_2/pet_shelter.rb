class Owner
  attr_reader :name
  attr_accessor :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    @pets.size
  end

  def print_pets
    pets.each { |pet| puts pet}
  end

  def add_pet(pet)
    @pets << pet
  end
end

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Shelter
  def initialize
    @owners = {}
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts ""
    end
  end
end

# Consider the following code:

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
napoleon     = Pet.new('dog', 'Napoleon')
maximilian   = Pet.new('dog', 'Maximilian')
emaline      = Pet.new('cat', 'Emaline')
charlemagne  = Pet.new('guinea pig', 'Charlemagne')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
# Write the classes and methods that will be necessary to make this code run, and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin
#
# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester
#
# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.

# Further Exploration
puts ""
puts "FURTHER EXPLORATION"
puts ""
module Pets
  def number_of_pets
    @pets.size
  end

  def add_pet(pet)
    @pets << pet
  end

  def print_pets
    @pets.each { |pet| puts pet}
  end
end

class Owner
  include Pets

  attr_reader :name
  attr_accessor :pets

  def initialize(name)
    @name = name
    @pets = []
  end


end

class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Shelter
  include Pets

  attr_reader :name

  def initialize(name)
    @name = name
    @owners = {}
    @pets = []
  end

  def adopt(owner, pet)
    owner.add_pet(@pets.delete(pet))
    @owners[owner.name] ||= owner
  end

  def print_adoptions
    @owners.each do |name, owner|
      puts "#{name} has adopted the following pets:"
      owner.print_pets
      puts ""
    end
  end

  def print_unadopted
    puts "#{name} has the following unadopted pets:"
    print_pets
    puts ""
  end
end

# Consider the following code:

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
napoleon     = Pet.new('dog', 'Napoleon')
maximilian   = Pet.new('dog', 'Maximilian')
emaline      = Pet.new('cat', 'Emaline')
charlemagne  = Pet.new('guinea pig', 'Charlemagne')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
ahenegar = Owner.new('A Henegar')
jgollup = Owner.new('J Gollup')

shelter = Shelter.new('The Animal Shelter')
shelter.add_pet(butterscotch)
shelter.add_pet(pudding)
shelter.add_pet(darwin)
shelter.add_pet(kennedy)
shelter.add_pet(sweetie)
shelter.add_pet(molly)
shelter.add_pet(chester)
shelter.add_pet(napoleon)
shelter.add_pet(maximilian)
shelter.add_pet(emaline)
shelter.add_pet(charlemagne)


shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, chester)
shelter.adopt(jgollup, napoleon)
shelter.adopt(ahenegar, maximilian)
shelter.adopt(ahenegar, emaline)
shelter.adopt(jgollup, charlemagne)

shelter.print_adoptions
shelter.print_unadopted
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{ahenegar.name} has #{ahenegar.number_of_pets} adopted pets."
puts "#{jgollup.name} has #{jgollup.number_of_pets} adopted pets."
puts "#{shelter.name} has #{shelter.number_of_pets} adopted pets."
