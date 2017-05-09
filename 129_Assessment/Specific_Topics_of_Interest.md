# Specific Topics of Interest

## Classes and objects
A class is the basic outline of what an object is made of and what it should be able to do. It is a group of code that has been placed together to enhance the flexibility and readability of the program. A class is used to instantiate objects which represent the class in a particular state using instance variables and its particular behaviors using instance methods. Multiple instances of a class may be created.
For ex: a `Cat` class may contain code to create the state and behavior of a general cat. Instance variables are used to declare properties such as `@name`, `age`, `sound`, `mood`, and whatever else you need to describe about a cat. Instance methods are then used to describe the behavior of the cat. They may report the cat's name and age, have the cat speak, or change its mood.
```ruby
class Cat
  def initialize(name, age, mood)
    puts "I am a new cat object!"
    @name = name
    @age = age
    @mood = mood
  end

  def info
    "My name is #{@name}. I am #{@age} years old and I am #{@mood}"
  end
end

chester = Cat.new('Chester', 15, 'frumpy') # => "I am a new cat object!"
puts chester.info # => "My name is Chester. I am 15 years old and I am frumpy."
```
Here, the `initialize` method is automatically run when a new instance of `Cat` is created. The instance method `info` is called on the cat object which returns the basic state of the cat.
## Use attr_* to create setter and getter methods
#### Use of attr_reader
```ruby
class Cat
  attr_reader :name, :age

  def initialize(name, age, mood)
    puts "I am a new cat object!"
    @name = name
    @age = age
    @mood = mood
  end

  def display_name
    puts "My name is #{name}."
  end

  def display_age
    puts "I am #{age} years old."
  end

  def display_mood
    puts "I am #{mood}."
  end
end

chester = Cat.new('Chester', 15, 'frumpy') # => "I am a new cat object!"
chester.display_name
chester.display_age
chester.display_mood # => NameError
```
The `attr_reader` creates a getter method that allows that variable to be read using an instance method with the same name. This means that the variable is not accessed directly, but through a getter method. The error when trying to print the mood in the above code arises because a getter method is not defined for `@mood`.
#### Use of attr_writer
```ruby
class Cat
  attr_writer :name, :age

  def initialize(name, age, mood)
    puts "I am a new cat object!"
    @name = name
    @age = age
    @mood = mood
  end

  def display_name
    puts "My name is #{@name}."
  end

  def display_age
    self.age = 400
    puts "I am #{@age} years old."
  end

  def display_mood
    puts "I am #{@mood}."
  end
end

chester = Cat.new('Chester', 15, 'frumpy') # => "I am a new cat object!"
chester.name = 'Bill'
chester.display_name # => My name is Bill.
chester.display_age # => I am 400 years old.
cheseter.mood = 'happy'
chester.display_mood # => NameError
```
The `attr_writer` creates a setter method that allows that variable to be altered using an instance method with the same name. The error when trying to change the mood in the above code arises because a setter method is not defined for `@mood`.
When calling a setter method from inside a class, `self` must be used to distinguish between called a setter method and defining a local variable. This is exemplified with `display_age`.
#### attr_accessor
This one is simple. `attr_accessor` will create both a getter and a setter method. It is simply more compact code.
## How to call setters and getters
#### Getter Method
Inside a class, simply type the name of the instance variable without `@`. This will call the getter method.
Outside a class, `<class>.<getter_method>`. In the example below, `chester.name`.
```ruby
class Cat
  attr_reader :name

  def initialize(name, age, mood)
    puts "I am a new cat object!"
    @name = name
    @age = age
    @mood = mood
  end

  def display_name
    puts "My name is #{name}."
  end
end

chester = Cat.new('Chester', 15, 'frumpy') # => "I am a new cat object!"
puts chester.name # => Chester
```
#### Setter Method
Inside a class, prefix method call with `self` to distinguish calling the method with setting a local variable.
Outside a class, <class>.<setter_method>. In the example below, `chester.name =`.
```ruby
class Cat
  attr_writer :name

  def initialize(name, age, mood)
    puts "I am a new cat object!"
    @name = name
    @age = age
    @mood = mood
  end

  def display_name
    self.name = 'Bill'
    puts "My name is #{name}."
  end
end

chester = Cat.new('Chester', 15, 'frumpy') # => "I am a new cat object!"
chester.name = 'Bill' # instance variable `@name` of chester is now `Bill`
```
## Instance methods vs. class methods
Instance methods are specific to a particular instance of a class and do not interfere with other instances of the class. Instance methods are used to access or modify the state of an object. They represent the object's behavior. They are used to expose information about the object.
Class methods are methods that are called directly on the class and not on the instance of a class. These methods should not pertain to any individual object but to the class as a whole. Class methods are defined by prepending `self` to the name of the method. Objects contain state, if we have a method that does not deal with state, then a class method is appropriate.
## Referencing and setting instance variables vs. using getters and setters
To reference an instance variable inside a class, use the entire instance variable name. Following the code examples above, use `@name` to get or set an instance variable directly.

To reference an instance variable using a getter method inside a class, define the getter method and then call that method. For the instance variable `@name`, the getter method should be called `name`. Therefore just call `name` to access its value. This also allows you to call `<class>.name` outside of the class to access the value of `@name`.

To set an instance variable directly inside a class, use the entire instance variable name. Use `@name = <value>` to set the value of `@name` directly.

to set an instance variable using a setter method inside a class, define the setter method and then call that method. For `@name`, use `self.name = <value>`. `self` must be used to distinguish between setting the variable and creating a new local variable of `name`. This also allows you to call `<class>.name = <value>` outside of the class to set the value of `@name`.

## Class inheritance, encapsulation, and polymorphism
#### Class inheritance
This is where a `subclass` inherits methods/classes from a `superclass`. Ex: `class Cat < Animal` shows that `Cat` inherits the behaviors from its superclass `Animal`. __A class may only sub-class from one super class__.

#### Encapsulation
This is the concept of hiding data so it is only accessed or manipulated with intent. It is what defines the boundaries of an application - it is the interface in which users interact. On one side of the interface, users have a set of tools/functions/methods they can use/invoke while the other side of the interface contains all the private and protected methods and variables the user should never (or does not need to) see.

By grouping data in this manner, code can be abstracted to a higher level. When you use a method called `display_total` you do not have to guess what it will do. This means the logic inside `display_total` doesn't even need to be understood, only how to call it is important.

#### Polymorphism
This is the concept of being able to reuse code for different purposes.

__Inheritance__ is one way to exercise the polymorphic nature of classes. Code from a `superclass` is given to its `subclass` to use as its own.

__Modules__ are another way to apply polymorphism. To do this, connect methods/variable are grouped into a module. This module is then included in one or more classes to use as their own. This is called a __mixin__.


## Modules
As described above, modules are used to mixin a group of methods into a class for it use.
## Method lookup path
Here is the general lookup path for a method:
1. The class itself
2. The modules mixed in (in reverse order listed)
3. The super class
4. The super class's modules mixed in
5. (repeat steps 3 & 4 if super class has a super class)
5. Object
6. Kernel
7. BasicObject

## self
### Calling methods with self
### More about self
## Reading OO code
## Fake operators and equality
## Truthiness
## Working with collaborator objects