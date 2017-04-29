#### Question 1
If we have this code:
```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```
What happens in each of the following cases:

case 1:
```ruby
hello = Hello.new
hello.hi
```
case 2:
```ruby
hello = Hello.new
hello.bye
```
case 3:
```ruby
hello = Hello.new
hello.greet
```
case 4:
```ruby
hello = Hello.new
hello.greet("Goodbye")
```
case 5:
```ruby
Hello.hi
```

##### Answer 1
case 1: # => 'Hello'
case 2: # => NoMethodError
case 3: # => ArgumentError
case 4: # => 'Goodbye'
case 5: # => NoMethodError (no class method)

#### Question 2
In the last question we had the following classes:
```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```
If we call `Hello.hi` we get an error message. How would you fix this?

##### Answer 2
```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greeting = Greeting.new # => note: can't simplay call `greet`
    # => since `Greeting` only defines `greet` on its instances. 
    greeting.greet('Hello')
  end

  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

#### Question 3

When objects are created they are a separate realization of a particular class.

Given the class below, how do we create two different instances of this class, both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

##### Answer 3
```ruby
bill = AngryCat(14, 'Bill')
larry = AngryCat(17, 'Larry')
```

#### Question 4

Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"
```ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```
How could we go about changing the `to_s` output on this method to look like this: `I am a tabby cat`? (this is assuming that `"tabby"` is the `type` we passed in during initialization).

##### Answer 4
```ruby
class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end
```

#### Question 5

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
What would happen if I called the methods like shown below?
```ruby
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
```
##### Answer 5
1. A new instance of `Television` is created and assigned to `tv`
2. Call the `manufacturer` method on `tv`. Produces NoMethodError because `manufacturer` is a class method.
3. Call instance method `model`.
4. 
5. Call class method `manufacturer` on `Television` class.
6. Call instance method `model` on class `Television`. Produces NoMethodError

#### Question 6

If we have a class such as the one below:
```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```
In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix?

##### Answer 6
In this case `self` is referencing the setter method provided by `attr_accessor`. So in this case `self` and `@` are the same thing and can be used interchangeably.

#### Question 7

What is used in this class but doesn't add any value?
```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end
```
##### Answer 7
The `return` isn't needed since Ruby implicitly returns the last line of a method unless it is explicitly written elsewhere in the method.
The getter methods aren't used either but give the class functionality for future code.