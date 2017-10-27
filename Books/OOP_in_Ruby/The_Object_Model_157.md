# The Object Model
## Why Object Oriented Programming?
__Object Oriented Programming (OOP)__ is a programming style created to handle the growing complexity of large software systems. It allows data to be organized into containers that can be easily modified without rippling dependency effects destroying the program.

Some OOP terminology:


__Polymorphism__: "many forms". It is the ability to re-use code for new purposes and it helps keep code DRY.

* __Inheritance__: This is one way Ruby uses polymorphism - one class inheriting behaviors from another.

* __Module__: A group of related code that can be mixed in to multiple classes. Modules have another use - to create namespace.

## What Are Objects?
In Ruby, EVERYTHING is an object. Objects are created from classes and represent a particular state of the class. This of classes as the mold and objects as the final product. Each object of a class may contain different information but still be instances of the same class. Take this example of the `String` class.
```irb
irb(main):001:0> "hello".class
=> String
irb(main):002:0> "world".class
=> String
irb(main):003:0>
```
Each object (`"hello"` and `"world"`) are instances of the `String` class but contain different states.

## Classes Define Objects
A __class__ will define both the __attributes__ and __behaviors__ of its objects. The attributes are what an object should be made of and the behaviors are what an object should be able to do. It is easy to create a class.
```ruby
# good_dog.rb

class GoodDog
end

sparky = GoodDog.new
```
In the above code we have created a class `GoodDog` and used it to instantiate an object with `GoodDog.new` and assigned it to the variable `sparky`. We can instantiate as many objects of the class as we need.
```ruby
sparky = GoodDog.new
bill = GoodDog.new
fred = GoodDog.new
```
## Modules
A module is a collection of behaviors that is useable in classes via __mixins__. A indicated by the bold word, the behaviors in a module are mixed into a class using the `include` keyword. In our example, to have our `GoodDog` objects be able to `speak` we can choose to define the `speak` method in a module and mix it into the `GoodDog` class.
```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

sparky = GoodDog.new
sparky.speak("Arf!")    # => Arf!
bob = HumanBeing.new
bob.speak("Hello!")     # => Hello!
```
In the above example, we have added the `speak` functionality to both the `GoodDog` and `HumanBeing` classes which gives all the objects of each class the ability to `speak`. It is as if we copy-pasted the `speak` method into each class.

## Method Lookup
```ruby
module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class GoodDog
  include Speak
end

class HumanBeing
  include Speak
end

puts "---GoodDog ancestors---"
puts GoodDog.ancestors
puts "---HumanBeing ancestors---"
puts HumanBeing.ancestors
```
Here is the output:
```
---GoodDog ancestors---
GoodDog
Speak
Object
Kernel
BasicObject

---HumanBeing ancestors---
HumanBeing
Speak
Object
Kernel
BasicObject
```
We can see that the `Speak` module was inserted right between our custom class and the `Object` class. Since `speak` was not defined in our custom class, Ruby then looked in the `Speak` module and found it there. At this point, Ruby stops looking and called the `speak` method.