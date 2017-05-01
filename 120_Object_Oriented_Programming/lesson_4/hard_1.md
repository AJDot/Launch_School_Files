# Exercises: Hard 1
#### Question 1

Alyssa has been assigned a task of modifying a class that was initially created to keep track of secret information. The new requirement calls for adding logging, when clients of the class attempt to access the secret data. Here is the class in its current form:
```ruby
class SecretFile
  attr_reader :data

  def initialize(secret_data)
    @data = secret_data
  end
end
```
She needs to modify it so that any access to `data` must result in a log entry being generated. That is, any call to the class which will result in data being returned must first call a logging class. The logging class has been supplied to Alyssa and looks like the following:
```ruby
class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end
```
Hint: Assume that you can modify the `initialize` method in `SecretFile` to have an instance of `SecurityLogger` be passed in as an additional argument. It may be helpful to review the [lecture on collaborator objects](https://launchschool.com/lessons/dfff5f6b/assignments/3748) for this exercise.

##### Answer 1
```ruby
class SecretFile
  # remove attr_reader for data and add attr_reader for logger
  attr_reader :logger

  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end

  # create explicit method to access data
  # have current time pushed onto logger, then return data
  def data
    @logger.create_log_entry
    @data
  end
end

# this may be a basic implementation of the SecurityLogger class
# The logger is simply an array of times the file is accessed
class SecurityLogger
  def initialize
    @access_log = []
  end

  def create_log_entry
    @access_log << "Accessed #: #{@access_log.size + 1} on #{Time.now}"
  end

  def display_log
    @access_log.each { |entry| puts entry }
  end
end

file = SecretFile.new('SECRET DATA', SecurityLogger.new)
file.logger.display_log # => Log: []
puts file.data          # => SECRET DATA
file.logger.display_log # => Log: ["Accessed on 2017-04-30 17:45:08 +0000"]
puts file.data          # => SECRET DATA
file.logger.display_log # => Log: ["Accessed on 2017-04-30 17:45:08 +0000", "Accessed on 2017-04-30 17:45:08 +0000"]
```
#### Question 2

Ben and Alyssa are working on a vehicle management system. So far, they have created classes called `Auto` and `Motorcycle` to represent automobiles and motorcycles. After having noticed common information and calculations they were performing for each type of vehicle, they decided to break out the commonality into a separate class called `WheeledVehicle`. This is what their code looks like so far:
```ruby
class WheeledVehicle
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end
```
Now Alan has asked them to incorporate a new type of vehicle into their system - a `Catamaran` defined as follows:
```ruby
class Catamaran
  attr_accessor :propeller_count, :hull_count, :speed, :heading

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end
```
This new class does not fit well with the object hierarchy defined so far. Catamarans don't have tires. But we still want common code to track fuel efficiency and range. Modify the class definitions and move code into a Module, as necessary, to share code among the `Catamaran` and the wheeled vehicles.

##### Answer 2
```ruby
# move all common code to a module called "Moveable"
module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  # variables defined in the module must now use the getter method otherwise
  # @fuel_efficiency and @fuel_capacity will no longer have the correct scope.
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran
  include Moveable

  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    # ... code omitted ...
  end
end

car = Auto.new
bike = Motorcycle.new
boat = Catamaran.new(2, 2, 10, 20)
puts "Range of car: #{car.range}"
puts "Range of bike: #{bike.range}"
puts "Range of boat: #{boat.range}"
```
#### Question 3

Building on the prior vehicles question, we now must also track a basic motorboat. A motorboat has a single propeller and hull, but otherwise behaves similar to a catamaran. Therefore, creators of `Motorboat` instances don't need to specify number of hulls or propellers. How would you modify the vehicles code to incorporate a new `Motorboat` class?

##### Answer 3
```ruby
# create class for all water craft
class Seacraft
  include Moveable

  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    self.propeller_count = num_propellers
    self.hull_count = num_hulls
    # ... code omitted ...
  end
end

# is subclass of Seacraft
class Catamaran < Seacraft
# will use initialize method from super - nothing to override
end

# is subclass of Seacraft
class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # motorboats have 1 propeller and hull
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

speedboat = Motorboat.new(10, 20)
puts "Range of speedboat: #{speedboat.range}"
puts "speedboat propellers: #{speedboat.propeller_count}"
puts "speedboat hull: #{speedboat.hull_count}"
```
#### Question 4

The designers of the vehicle management system now want to make an adjustment for how the `range` of vehicles is calculated. For the seaborne vehicles, due to prevailing ocean currents, they want to add an additional 10km of range even if the vehicle is out of fuel.

Alter the code related to vehicles so that the range for autos and motorcycles is still calculated as before, but for catamarans and motorboats, the range method will return an additional 10km.

##### Answer 4
```ruby
# add this instance method to Seacraft class.
# This way Auto and Motorcycle will not be affected but Catamaran and Motorboat
# will be.
def range
  range_by_using_fuel = super
  range_by_using_fuel + 10
end
```