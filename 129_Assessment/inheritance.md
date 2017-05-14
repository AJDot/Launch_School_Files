### Demonstrate the use the modules as mixins and explain when they are necessary.

To demonstrate modules as mixins we need to come up with a scenario in which class inheritance does not satisfy the requires on its own.

Take this set of classes:
```ruby
class Animal; end

class Bird < Animal; end

class Arthropod < Animal; end

class Falcon < Bird; end

class Penguin < Bird; end

class Butterfly < Arthropod; end
```

With this class structure, the inheritance tree is as follows.

* Animal
  * Bird
    * Falcon
    * Penguin
  * Arthropod
    * Butterfly

So `Bird` and `Arthropod` inherit from `Animal`, `Falcon` and `Penguin` inherit from `Bird`, and `Butterfly` inherits from `Arthropod`.
***
#### When class inheritance alone will solve the problem.
When all branches should inherit a method, class inheritance should be used.

All of these animals have the ability to walk so we can place the `walk` method inside the `Animal` class.

To implement the `walk` method, we can place it in the `Animal` class.

```ruby
class Animal
  def walk
    "An instance of the #{self.class} class is walking."
  end
end

class Bird < Animal; end

class Arthropod < Animal; end

class Falcon < Bird; end

class Penguin < Bird; end

class Butterfly < Arthropod; end

puts Animal.new.walk # => An instance of the Animal class is walking.
puts Bird.new.walk # => An instance of the Bird class is walking.
puts Arthropod.new.walk # => An instance of the Arthropod class is walking.
puts Falcon.new.walk # => An instance of the Falcon class is walking.
puts Penguin.new.walk # => An instance of the Penguin class is walking.
puts Butterfly.new.walk # => An instance of the Butterfly class is walking.
```
We have successfully implemented the `walk` method using class inheritance. This code is now ad DRY as possible.

#### When class inheritance is not possible, use a modules as a mixin.
We now want to give some of the animals the ability to fly. Our first attempt will be to use only class inheritance. The animals that can fly should be the `Falcon` and the `Butterfly`. These classes have different superclasses so we must look one level higher until we find a common class that both `Falcon` and `Butterfly` inherit from. Here, it is the `Animal` class. Let's place `#fly` in the `Animal` class.
```ruby
class Animal
  def walk
    "An instance of the #{self.class} class is walking."
  end

  def fly
    "An instance of the #{self.class} class is flying."
  end
end

class Bird < Animal; end

class Arthropod < Animal; end

class Falcon < Bird; end

class Penguin < Bird; end

class Butterfly < Arthropod; end

puts Animal.new.fly # => An instance of the Animal class is flying.
puts Bird.new.fly # => An instance of the Bird class is flying.
puts Arthropod.new.fly # => An instance of the Arthropod class is flying.
puts Falcon.new.fly # => An instance of the Falcon class is flying.
puts Penguin.new.fly # => An instance of the Penguin class is flying.
puts Butterfly.new.fly # => An instance of the Butterfly class is flying.
```

We have successfully given `Falcon` and `Butterfly` the ability to `#fly` but in the process we gave the `Penguin` the ability as well. To only give the appropriate animals the ability to fly we should place `#fly` in a module and include it in every class it is needed.
```ruby
module Flyable
  def fly
    "An instance of the #{self.class} class is flying."
  end
end

class Animal
  def walk
    "An instance of the #{self.class} class is walking."
  end
end

class Bird < Animal; end

class Arthropod < Animal; end

class Falcon < Bird
  include Flyable
end

class Penguin < Bird; end

class Butterfly < Arthropod
  include Flyable
end

puts Animal.new.fly # => NoMethodError
puts Bird.new.fly # => NoMethodError
puts Arthropod.new.fly # => NoMethodError
puts Falcon.new.fly # => An instance of the Falcon class is flying.
puts Penguin.new.fly # => NoMethodError
puts Butterfly.new.fly # => An instance of the Butterfly class is flying.
```

Success! Now only the animals that should be able to fly can fly.