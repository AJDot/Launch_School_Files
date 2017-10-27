# Class Inheritance
#### Explain class inheritance and why it is useful. Use code to support your answer.
Here is some "wet" code.
```ruby
class Dog
  def initialize(name)
    @name = name
  end

  def walk
    "I am walking."
  end

  def run
    "I am running."
  end
end

class Cat
  def initialize(name)
    @name = name
  end

  def walk
    "I am walking."
  end

  def run
    "I am running."
  end
end

class Pig
  def initialize(name)
    @name = name
  end

  def walk
    "I am walking."
  end

  def run
    "I am running."
  end
end
```
Ugly. We have repeated ourselves 3 times and even though there are common methods between each class. Class inheritance is the natural solution to this problem. These classes have common methods that can be extracted to a superclass named `Animal`. We can then make each of these subclasses inherit behavior from `Animal` like so:
```ruby
class Animal
  def initialize(name)
    @name = name
  end

  def walk
    "I am walking."
  end

  def run
    "I am running."
  end
end

class Dog < Animal; end
class Cat < Animal; end
class Pig < Animal; end

```
And there was go. Now each subclasses has the behaviors of its superclass with minimal amount of coding necessary and no repetition.