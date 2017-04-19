puts "------------"
puts "Exercise 1"
puts "------------"


# How do we create an object in Ruby? Give an example of the creation of an object.

# ANSWER
# An object is by using the #new method on a class. A class is defined using the 'class' reserved word like a method using 'def'

class House

end

# the object 'my_house' is instantiated by using the #new method of the class #House
my_house = House.new

puts House.ancestors

puts "------------"
puts "Exercise 2"
puts "------------"

# What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# ANSWER
# A module is a collection of behaviors that can be used by multiple classes. They can give additional functionality to multiple classes without having to upend all code to make the change.

module OpenDoor
  def open_door
    puts "You opened the door"
  end
end

class House
  include OpenDoor
end

my_house.open_door
