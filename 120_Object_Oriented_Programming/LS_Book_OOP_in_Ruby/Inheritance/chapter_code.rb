module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable
  
  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
  
  DOG_YEARS = 7
  
  attr_accessor :name, :age
  
  def initialize(n, a)
    self.name = n
    self.age  = a
  end
  
  def public_disclosure
    "#{self.name} in human years is #{human_years}"
  end
  
  private
  
  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky.public_disclosure