# Exercises: Easy 2


#### Question 1

You are given the following code:
```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```
What is the result of calling
```ruby
oracle = Oracle.new
oracle.predict_the_future
```
##### Answer 1
It will be one of 3 things.
```ruby
"You will eat a nice lunch"
"You will take a nap soon"
"You will stay at work late"
```
The specific string will be chosen randomly.

#### Question 2

We have an `Oracle` class and a `RoadTrip` class that inherits from the `Oracle` class.
```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```
What is the result of the following:

```ruby
trip = RoadTrip.new
trip.predict_the_future
```
##### Answer 2
Same as Question 1 but the choices will now be the choices in the `RoadTrip` class, not in the `Oracle` class.

#### Question 3

How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?
```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```
What is the lookup chain for `Orange` and `HotSauce`?

##### Answer 3
Use `<object>.anscestors`.
```irb
2.4.0 :015 >   puts HotSauce.ancestors
HotSauce
Taste
Object
Kernel
BasicObject

2.4.0 :031 > puts Orange.ancestors
Orange
Taste
Object
Kernel
BasicObject
```

#### Question 4

What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?
```ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```
##### Answer 4
```ruby
class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end
```

#### Question 5

There are a number of variables listed below. What are the different types and how do you know which is which?
```ruby
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```
##### Answer 5
`excited_dog` => local variable (no @ symbol)
`@excited_dog` => instance variable (1 @ symbol)
`@@excited_dog` => class variable (2 @ symbols)

#### Question 6

If I have the following class:
```ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```
Which one of these is a class method (if any) and how do you know? How would you call a class method?

##### Answer 6
`manufacturer` is a class method because it is prefixed by `self.`
Class methods can be called on the class itself. `Television.manufacturer`

#### Question 7

If we have a class such as the one below:
```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```
Explain what the `@@cats_count` variable does and how it works. What code would you need to write to test your theory?

##### Answer 7
The `@@cats_count` variable keep track of how many instances of the `Cat` class have been invoked. Here is some code to test that theory.
```ruby
puts Cat.cats_count     # => 0
bill = Cat.new('hairy')
puts Cat.cats_count     # => 1
fred = Cat.new('furry')
Cat.new('fluffy')
puts Cat.cats_count     # => 3
```

#### Question 8

If we have this class:
```ruby
class Game
  def play
    "Start the game!"
  end
end
```
And another class:
```ruby
class Bingo
  def rules_of_play
    #rules of play
  end
end
```
What can we add to the Bingo class to allow it to inherit the play method from the Game class?

##### Answer 8
```ruby
class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

#### Question 9

If we have this class:
```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```
What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.

##### Answer 9
This functionality of `play` in the `Bingo` class would change to the new definition. The method lookup chain will first look for `play` in the current class, then reach to inherited classes and other places.

#### Question 10

What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

##### Answer 10
OOP is beneficial for the following reasons:
1. The DRY methodology can be implemented to a greater extent.
1. Modular & customizable - breaking up and sectioning code in this natural way provides a platform that allows for much greater flexibility to alter the code when necessary.
1. The code is typically easier to read (but harder to implement). If the classes and methods are named appropriately then the code should read almost like English.

_LS Answers_
1. Creating objects allow programmers to think more abstractly about the code they are writing.
1. Objects are represented by nouns so are easier to conceptualize.
1. It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
1. It allows us to easily give functionality to different parts of an application without duplication.
1. We can build applications faster as we can reuse pre-written code.
1. As the software becomes more complex this complexity can be more easily managed.
