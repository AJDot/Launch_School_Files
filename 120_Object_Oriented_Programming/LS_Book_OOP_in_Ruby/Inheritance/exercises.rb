class Vehicle
  attr_accessor :year, :color, :model, :number_of_vehicles
  
  @@number_of_vehicles = 0
  
  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles."
  end
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
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
  
  def self.gas_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end
  
  def age
    "Your #{self.model} is #{current_age} years old."
  end
  
  private
  
  def current_age
    Time.now.year - self.year.to_i
  end
    
end

module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  def to_s
    "My car is a #{color}, #{year} #{model}."
  end
end

class MyTruck < Vehicle
  include Towable
  
  NUMBER_OF_DOORS = 2
  
  def to_s
    "My truck is a #{color}, #{year} #{model}."
  end
end

puts ""
puts "------------"
puts "Exercise 1"
puts "------------"
car = MyCar.new("2010", "Silver", "Ford Focus")
truck = MyTruck.new("2010", "Red", "Toyota Tundra")
puts car
puts truck

puts ""
puts "------------"
puts "Exercise 2"
puts "------------"

Vehicle.number_of_vehicles
vehicle3 = MyCar.new("2019", "Blue", "Bicycle")
Vehicle.number_of_vehicles


puts ""
puts "------------"
puts "Exercise 3"
puts "------------"

vehicle4 = MyTruck.new("2010", "Green", "Awesomeness")

puts vehicle4.can_tow?(1820)

puts ""
puts "------------"
puts "Exercise 4"
puts "------------"
puts "---MyCar Method Lookup---"
puts MyCar.ancestors
puts ""
puts "---MyTruck Method Lookup---"
puts MyTruck.ancestors
puts ""
puts "---Vehicle Method Lookup---"
puts Vehicle.ancestors
puts ""

puts ""
puts "------------"
puts "Exercise 5"
puts "------------"

puts ""
puts "------------"
puts "Exercise 6"
puts "------------"
vehicle5 = MyCar.new("2003", "Yellow", "Mazda")
puts vehicle5.age

puts ""
puts "------------"
puts "Exercise 7"
puts "------------"

class Student
  
  
  def initialize(n, g)
    @name   = n
    @grade  = g
  end
  
  def better_grade_than?(other_student)
    @grade > other_student.grade
  end
  
  protected
  
  def grade
    @grade
  end
end

bob = Student.new("Bob", 69)
joe = Student.new("Joe", 87)
puts "Well done!" if joe.better_grade_than?(bob)

puts ""
puts "------------"
puts "Exercise 8"
puts "------------"
# The method #hi is defined in the class #Person but it is not a public method. it is a private method as stated on line 1 of the error. The #hi method needs to be made public in order to access it. Move the method above the reserve word 'private' in the class. 