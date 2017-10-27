# Specific Topics of Interest

## Classes and objects
A class is the basic outline of what an object is made of and what it should be able to do. It is a group of code that has been placed together to enhance the flexibility and readability of the program. A class is used to instantiate objects which represent the class in a particular state using instance variables and its particular behaviors using instance methods. Multiple instances of a class may be created.
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

chester.display_name # => My name is Bill.
chester.display_age # => I am 400 years old.
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
    puts "My name is #{name}."
  end
end

```
## Instance methods vs. class methods
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
5. (repeat steps 3 & 4 if super class has a super class)
5. Object
6. Kernel
7. BasicObject

## self
### Calling methods with self
To use setter methods inside a class, `self` must be prepended to the variable name. If this is not done, then Ruby will think we are trying to create new local variables. Ex:
```ruby
# Bad
def update_info(new_name, new_age, new_mood)
  name = new_name
  age = new_age
  mood = new_mood
end

# Good
def update_info(new_name, new_age, new_mood)
  self.name = new_name
  self.age = new_age
  self.mood = new_mood
end
```
In the bad example, new local variables are created which do not change the state of the object.
In the good example, the instance variables of the object are changed and the instance method works as intended.
***
This could be used to call the getter methods as well but it is not necessary.
***
Lasty, `self` can be used with any instance method. The point is that it is required only for setter methods.
### More about self
Two clear use cases for `self`:
1. `self` must be used when calling setter methods from within a class.
  __From within a class__, when an __instance method__ calls `self`, it is returning the _calling object_. For our code above:
```ruby
class Cat
  # ... rest of code

  def what_is_self
    self
  end
end

p chester.what_is_self
  # => #<Cat:0x320c538 @name="Chester", @age=15, @mood="frumpy">
```
2. Use `self` for class method definitions.
  __From within a class but outside an instance method__, `self` refers to the class itself - not a particular instance of the class.
```ruby
  class Cat
    # ... rest of code
    puts self
  end
  Cat # => Cat
```
## Reading OO code
## Fake operators and equality
### Equality
#### The == method
```ruby
class Cat
  # ... rest of code

  attr_accessor :name

  def =(other)
    name == other.name
  end
end


chester == chester2 # => true (since their names are the same)
```
The above `==` method uses the `==` method from the `String` class to compare the names of the cats.
***
`object_id`
Every object has a unique identifier. We can use this to see if two variables are pointing to the same object. Symbols and Integers have slightly different behavior in that there will only ever be one object with a particular value.
#### The equal? method
Determines whether two variables point to the same object.
#### The === method
This is used implicitly by the `case` statement.
#### The eql? method
#### Summary
`==`
* the `==` operator is actually a method. Most built-in Ruby class, like `Array`, `String`, `Fixnum`, etc override the `==` method to specify how to compare objects of those class.
* if you need to compare custom objects, you should override the `==` method.

`equal?`
* the `equal?` method goes one level deeper than `==` and determines whether two variables not only have the same value, but also whether they point to the same object.
* do not override `equal?`.
* the `equal?` method is not used very often.

`===`
* used implicitly in `case` statements.
* like `==`, the `===` operator is actually a method.
* you rarely need to call this method explicitly, and only need to implement it in your custom classes if you anticipate your objects will be used in `case` statements, which is probably pretty rare.

`eql?`
* use implicitly by `Hash`.
* very rarely used explicitly.
### Fake Operators
| Method | Operator | Description |
| --- | --- | --- |
| yes | `[]`, `[]=` | Collection element getter and setter |
| yes | `**` | Exponential Operator |
| yes | `!`, `~`, `+`, `-` | Not, complement, unary plus and minus (method names for the last two are +@ and -@ |
| yes |	`*`, `/`, `%`	| Multiply, divide, and modulo |
| yes |	`+`, `-` | Plus, minus |
| yes |	`>>`, `<<` | Right and left shift |
| yes |	`&`	| Bitwise "and" |
| yes |	`^`, <code>&#124;</code> | Bitwise inclusive "or" and regular "or"
| yes |	`<=`, `<`, `>`, `>=` | Less than/equal to, less than, greater than, greater than/equal to |
| yes |	`<=>`, `==`, `===`, `!=`, `=~`, `!~` | Equality and pattern matching (`!=` and `!~` cannot be directly defined)
| no | `&&` | Logical "and"
| no | <code>&#124;&#124;</code> | Logical "or"
| no | `..`, `...` |	Inclusive range, exclusive range |
| no | `?` `:`	| Ternary if-then-else |
| no | `=`, `%=`, `/=`, `-=`, `+=`, <code>&#124;=</code>, `&=`, `>>=`, `<<=`, `*=`, `&&=`, <code>&#124;&#124;=</code>, `**=`, `{` | Assignment (and shortcuts) and block delimiter |

#### Comparison methods
Overriding these makes the syntax nice for comparing objects.
The code below will compare `Cat` objects based on their age
```ruby
class Cat
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other)
    age > other.age
  end
end


chester > bill # => true
```

#### The `>>` and `<<` shift methods
Override these to again make the syntax nice for adding objects to a class.
```ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(cat)
    @members.push cat
  end

  def to_s
    members.collect(&:to_s).to_s
  end
end

class Cat
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other)
    age > other.age
  end

  def to_s
    @name.to_s
  end
end

furballs << chester
furballs << bill
puts furballs # => ["Chester", "Bill"]
```

#### Element setter and getter methods
The following code will give the `Team` class functionality to easily set and get its members.
```ruby
class Team
  # ... rest of code omitted for brevity

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end
```
## Truthiness
A boolean is an object whose only purpose is to convey whether it is "true" or "false".
In Ruby, booleans are represented by `true` and `false` objects. Since they are objects, they have a class behind them - the `TrueClass` and `FalseClass`.
```ruby
true.class # => TrueClass
true.nil? # => false
true.to_s # => "true"
true.methods # => list of methods you can call on the true object

false.class # => FalseClass
false.nil? # => false
false.to_s # => "false"
false.methods # => list of methods you can call on the false object
```
Truthiness is the concept that objects that are not `true` or `false` may be used in conditionals, etc as if they were a true or false. The question is, what should evaluate as if it was `true` and what should evaluate as if it was `false`? Ruby _considers everything to be truthy other than `false` and `nil`_.

This means that any expression can be used in a conditional.
```ruby
num = 5

if num
  puts "valid number"
else
  puts "error!"
end
```
This will print "valid number" as long as `num` is anything but `false` or `nil`.
## Working with collaborator objects

A collaborator object is an objects assigned to an instance (or class) variable. Essentially all instance variables are assigned to collaborator objects since everything in Ruby is an object. What this reveals is that custom objects may also be used as the collaborator object to a class.
```ruby
class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  attr_reader :name, :owner

  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

bill = Person.new("Bill")
chester = Cat.new("Chester", bill)

chester.owner # => #<Person:0x32eb750 @name="Bill">
```
Now we can see that the owner of Chester the `Cat` is a `Person` object with the name of "Bill".