class MyCar
  attr_accessor :year, :color, :model
  
  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end
  
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end
  
  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end
  
  def current_speed
    puts "You are now going #{@current_speed} mph."
  end
  
  def shut_off
    @current_speed = 0
    puts "You parked the car."
  end
  
  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end
  
  def to_s
    "You have a #{color}, #{year} #{model}."
  end
end

puts "------------"
puts "Exercise 1"
puts "------------"
puts ""
# Add a class method to your MyCar class that calculates the gas mileage of any car


MyCar.gas_mileage(351, 13)

puts "------------"
puts "Exercise 2"
puts "------------"
puts ""

car = MyCar.new('2003', 'Black', 'Ford Focus ZX3')
puts car

puts "------------"
puts "Exercise 3"
puts "------------"
puts ""
# When running the following code...

# class Person
#   attr_reader :name
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Steve")
# bob.name = "Bob"
# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
#   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)
# Why do we get this error and how to we fix it?

# ANSWER
# No setter method was created to set the value of @name.
# Using attr_reader :name allows you to read the value but not change it.
# Change this code to be attr_accessor :name, now you can read and write to @name.