# Classes and Objects - Part II
## Class Methods
We can also create class-level methods. Class methods are called directly on the class without having to instantiate an object. Use the `self.` reserved word to define one.
```ruby
# good_dog.rb
# .... rest of code

def self.what_am_i    # Class method definition
  "I'm a GoodDog class!"
end

GoodDog.what_am_i       # => I'm a GoodDog class!
```
When would a class method be necessary? If we have a method that does not need to deal with states, then we can just use a class method.

## Class Variables
Just as instance variables keep track of the state of the instance of a class, class variables keep track of the state of the class as a whole. __Class variables__ are created useing two `@` symbols like so: `@@`.
```ruby
class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs     # => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs     # => 2
```
The class variable named `@@number_of_dogs`, which is initialized to 0, is incremented every time an instance of the `GoodDog` class is created. This means that `@@number_of_dogs` will always represent the total number of `GoodDog` instances that have been created. Finally, `self.total_number_of_dogs` is a class method used to return this value. This information pertain to the class as a whole, not to a particular instance of the class.

## Constants
Constants are created just as they would be outside of a particular class. Constants are defined with a uppercase first letter but convention is to use all caps.
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age               # => 28
```
Here `DOG_YEARS` is used to calculate the object's age in dog years when human years are passed in.

`DOG_YEARS` is a variable that will never change for any reason so it should be made a constant.

## The to_s Method
The `to_s` method of any class is the default output when used with the `puts` method. When an object is printed, the default string that is return will contain the class name and an encoding of the object id.
```ruby
puts sparky       # => #<GoodDog:0x007fe542323320>
```
When can customize this return value by simply defining our own `to_s` method within our custom class.
```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age = a
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

puts sparky       # => This dog's name is Sparky and is 28 in dog years.
```
A similar method to `puts` is `p`. `p` does not call `to_s` on the object but instead calls `inspect`. This is very helpful for debugging as it will additionally output the state of the object (its instance variables and their values).

The `to_s` method can be very convenient as it is what is implicitly called when the object is called in string interpolation.

## More About self
There are two clear use cases for `self`:
1. Use `self` when calling a setter method from within a class.
2. Use `self` when defining class methods.

How is it possible to use the reserved word `self` in different ways such as this? To find this out, let's call `self` from within an instance method and from within a class but outside an instance method. Start with this code:
```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end
```
Add an instance method to figure out what `self` is inside it.
```ruby
class GoodDog
  # ...

  def what_is_self
    self
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
  # => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
```
Ah, so `self` inside of an instance method is the object that is doing the calling. In our example, this means that inside `change_info`, `self.name=` is the same as calling `sparky.name=` and this is how it looks when `change_info` is called from outside the class.

Now, for defining class methods we can use the following example:
```ruby
class GoodDog
  # ... rest of code
  puts self
end

GoodDog       # => Gooddog
```
So from within a class but outside an instance method, `self` refers to the class itself. So in our previous example, `self.total_number_of_dogs` is the same as `GoodDog.total_number_of_dogs`.

Summary - `self` changes depending on the scope it's defined in. Be careful.