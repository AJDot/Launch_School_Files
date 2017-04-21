puts "------------"
puts "Exercise 1"
puts "------------"
puts ""
# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :color
  attr_reader :year
  
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
end

car = MyCar.new(2003, 'Black', 'Focus ZX3')
car.speed_up(20)
car.brake(12)
car.current_speed
car.shut_off
car.current_speed

puts "------------"
puts "Exercise 2"
puts "------------"
puts ""

puts car.color
car.color = 'Brown'
puts car.color
puts car.year

puts "------------"
puts "Exercise 3"
puts "------------"
puts ""

puts car.color
car.spray_paint('Purple')
puts car.color