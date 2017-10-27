# Inheritance
Inheritance is when a class __inherits__ behavior from another class. The class that in inheriting is called the subclass and the class it inherits from is called the superclass.

Inheritance is used to extract common behaviors to keep our code DRY.

## Class Inheritance
Looking at our `GoodDog` class we can extract the `speak` method to a superclass `Animal`. In this way, `speak` can be inherited by every subclass of `Animal`.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new

puts sparky.speak   # => Hello!
puts paws.speak     # => Hello!
```
Class inheritance is signified with the `<` symbol. In the code above, both the `GoodDog` and `Cat` classes inherit all the methods from the `Animal` class.

What if the definition of `speak` in the `Animal` is not desired in the `GoodDog` class? We can simply overwrite it just like we did with the `to_s` method before.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new

puts sparky.speak           # => Sparky says arf!
puts paws.speak             # => Hello!
```

The `GoodDog` class overrides the `speak` method from the `Animal` class. By following the method lookup path, Ruby will look in the `GoodDog` class for the `speak` method first. Since it is found there, that is the definition that will be used. It is not found in the `Cat` class so Ruby then looks in `Animal` class.

Use inheritance to remove duplication of code - keep it DRY.

## super
Ruby has a built-in functioni called `super` that allows us to call methods up the inheritance hierarchy. When `super` is called from within a method, it will search up the method lookup to find a method with the same name and then invoke it.
```ruby
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  def speak
    super + " from GoodDog class"
  end
end

sparky = GoodDog.new
sparky.speak          # => "Hello! from GoodDog class"
```

`super` looks up the method chain and found a `speak` method in the `Animal` class and invoked it. That method is run and its functionality is extended by appending some text to the result.

`super` is often used in the `initialize` method.
```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")    # => #<GoodDog:0x89cc450 @name="brown", @color="brown">
```
When `super` was used in the above code, somehow the argument labelled `color` was passed to it and assigned to the instance variable `@name`. Then it is also assigned to the instance variable `@color`.

When called with no argument, _all_ arguments will be passed to `super`. When caled with specific arguments, only those arguments will be passed into `super`. Here is how we would use this knowledge to fix the code above.
```ruby
class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

BadDog.new(2, "bear")       # => #<BadDog:0x89e5a68 @name="bear", @age=2>
```

## Mixing in Modules
Class inheritance is a great way to DRY up code when concepts have a natural hierarchy. However, this will not always work out when behaviors do not have a natural hierarchy that flows with teh rests of the program. __Modules__ are another way to DRY up your code in Ruby.

* Animal
  * Fish
  * Mammal
    * Cat
    * Dog

```ruby
module Swimmable
  def swim
  end
end

class Animal; end

class Fish < Animal
  include Swimmable     # mixing in Swimmable module
end

class Mammal < Animal
end

class Cat < Mammal
  include Swimmable     # mixing in Swimmable module
end
```
```ruby
sparky = Dog.new
nemo = Fish.new
paws = Cat.new

paws.swim         # => NoMethodError
```

## Inheritance vs Modules
* You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.
*

## Method Lookup Path
When there is both class inheritance and mixins, where will Ruby look for a method? Take the following code:
```ruby
module Walkable
  def walk
  end
end

module Swimmable
  def swim
  end
end

module Climbable
  def climb
  end
end

class Animal
  include Walkable

  def speak
  end
end
```
We already know that `Walkable` will be insert after `Animal` in the lookup chain.
```ruby
puts "---Animal method lookup---"
puts Animal.ancestors
```
```
---Animal method lookup---
Animal
Walkable
Object
Kernel
BasicObject
```
If a method is not found anywhere in the list, a NoMethodError will be thrown.

What if another class and some more modules are thrown into the mix?
```ruby
class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors
```
And here is the output:
```
GoodDog
Climbable
Swimmable
Animal
Walkable
Object
Kernel
BasicObject
```
* So the order in which modules are included is important. Modules will be searched in reverse order from which they were included.

## More Modules
Modules may also be used for __namespacing__. In this context, namespacing simply means organizing similar classes under a module.
1. Related classes are easier to recognize.
2. The likelihood of class collisions is reduced.
```ruby
module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p #{name}
    end
  end
end
```
Classes can now be called in the following way using `::`.
```ruby
buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
```
The next use for modules is simply as a __container__ for methods, called module methods. This should be used for methods that seem out of place within your code.
```ruby
module Mammal
  # ...

  def self.some_out_of_place_method(num)
    num ** 2
  end
end
```
The follow is used to access that method:
```ruby
value = Mammal.some_out_of_place_method(4)
# OR
value = Mammal::some_out_of_place_method(4)
```
The former way is preferred.

## Private, Protected, and Public
***
Public method

***
Private method

***
Protected method

An in-between, `protected` methods follow these rules:
* from outside the class, `protected` methods act just like `private` methods.
* from inside the class, `protected` methods are accessible just like `public` methods.
