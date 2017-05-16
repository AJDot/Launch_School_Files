# Everything is Ruby is an Object
This post is in part my study guide as I prepare for the Launch School Course 129 Assessment.

## What is an Object?
Before we can demonstrate that everything in Ruby is an object we first have to define “object”. It’s natural to define “object” in terms of what creates them, classes. In short, classes are where Ruby defines the state and behavior of an object of that class. You can think of classes as the basic mold for what an object should be made of and what it can do. Let’s take a look at a simple example of defining a class and then creating an object of that class.
```ruby
class Animal
end

chester = Animal.new
```
This simple code has defined a class called Animal which was then used to instantiate a new Animal object with the code Animal.new and assign it to the variable chester. Objects of a class will possess info and abilities as defined in its class.

We can give our `Animal` objects some kind of state and behavior by adding instance methods and instance variables respectively:
```ruby
class Animal
  def initialize(name)
    @name = name
  end

  def walk
    "I am walking."
  end
end

chester = Animal.new('Chester')
puts chester.walk      # => I am walking.
```
In the above code, an object must now be instantiated with one argument that will be used to define the instance variable `@name`. This instance variable is part of the state of the object. The `walk` method defined in the class now gives `chester` the ability to `walk`. The last line `puts chester.walk` calls the `walk` method of the `Animal` object assigned to the variable `chester`. The output shows that `chester` can walk.

We can view the state of the object by calling `inspect` on the object using `p`.
```ruby
p chester   # => #<Animal:0x32b9260 @name="Chester">
```
This shows that `chester` is pointing to an object of the `Animal` class whose state is composed of one instance variable `@name` whose value is `Chester`.

In summary, an object represents of particular state of its class and possesses all the behavior as defined in the class.

## Everything in Ruby is an Object
Now that we can know the basics of what an object is and what it can do, let's look at some objects. We will use the `#class` method to determine each object's class.
```irb
irb:001> "This is a string.".class
=> String
irb:002> 42.class
=> Fixnum
irb:003> [1, 2, 3, 4].class
=> Array
irb:004> {a: 1, b: 2}.class
=> Hash
```
We have looked up plenty of information on each of these classes through our studies so these should not be surprising. But as it is said, everything is Ruby is an object. Let's look at some others:
```irb
irb(main):001:0> true.class
=> TrueClass
irb(main):002:0> false.class
=> FalseClass
irb(main):003:0> nil.class
=> NilClass
irb(main):004:0> (1..100).class
=> Range
irb(main):005:0> :forty_two.class
=> Symbol
irb(main):006:0> Math.class
=> Module
irb(main):007:0> Kernel.class
=> Module
irb(main):008:0> Module.class
=> Class
irb(main):009:0> Class.class
=> Class
```
Even `Class` is an object of `Class`. No need to get into that right now, but regardless, everything in Ruby is an object of some class.
