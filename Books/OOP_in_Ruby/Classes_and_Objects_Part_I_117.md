# Classes and Objects - Part I
## States and Behaviors
When creating a class, focus on two things: _states_ and _behaviors_. States track attributes for individual objects and behaviors are what objects are capable of doing.

for our `GoodDog` class, each object make contain different information - a name, weight, etc - but every object of the `GoodDog` class will contain identical behavior. For example, two `GoodDog` objects may have different names, weights, etc but all `GoodDog` objects will have the ability to bark, run, fetch, etc. So the state of each object may be different but the behavior that each is capable of are identical.

## Initializing a New Object
Take the `GoodDog` class and instantiate an object using the following code.
```ruby
# good_dog.rb

class GoodDog
  def initialize
    puts "This object was initialized"
  end
end

sparky = GoodDog.new      # => "This object was initialized!"
```
When an object is created using the `::new` method, it actually called an instance method named `initialize`. This method is referred to as a _constructor_ because it is triggered when a new object is constructed.

## Instance Variables
```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end
end
```
A variable prefixed with one `@` symbol is an __instance variable__. Instance variable exists as the long as the object instance exists; it is tied to object and lives on even after the `initialize` method is run. To create a new object we now need to supply the `::new` method with one argument which will be used to assign the instance variable `@name`.
```ruby
sparky = GoodDog.new("Sparky")
```
Here the `String` "Sparky" will be assigned to `@name`. It is these instance variables that keep track of the state of the object.

## Instance Methods
Just as instance variables keep track of the state, instance methods define the behaviors of the object.
```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "Arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak   # => Arf!
```
When the `speak` method is called, it will find it in the `GoodDog` class and return the `String` "Arf". We must then `puts` that string if we want to see it on the screen.

We could create more `GoodDog` objects and all would have the ability to `speak`.
```ruby
fido = GoodDog.new("Fido")
puts fido.speak   # => Arf!
```

An instance method may be customized to use the instance variables. For example, if we wanted each object to declare itself as the one who is speaking, we can do the following.
```ruby
def speak
  "#{@name} says arf!"
end
```
And now, whenever a `GoodDog` object calls the `speak` method, it will be personalized.
```ruby
puts sparky.speak   # => "Sparky says arf!"
puts fido.speak     # => "Fido says arf!"
```

## Accessor Methods
```ruby
puts sparky.name # => NoMethodError
```
Right now we do not have access to the `@name` instance variable from outside of the class. Ruby is looking for a method called `name` which we were hoping would return the `@name` variable. What this means is that we need to create a method that _will_ return the name. We can call this method whatever we want, how about `get_name`?
```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def speak
    "#{@name} says arf!"
  end
end

spark = GoodDog.new("Sparky")
puts sparky.speak       # => "Sparky says arf!"
puts sparky.get_name    # => "Sparky"
```
Success! We now have what we would call a _getter_ method because it retrieves a variable. We must perform a similar act if we want to _change_ an instance variable.
```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

  def get_name
    @name
  end

  def set_name=(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak               # => "Sparky says arf!"
puts sparky.get_name            # => "Sparky"
sparky.set_name = "Spartacus"
puts sparky.get_name            # => "Spartacus"
```
Ah, we have successfully changed the instance variable `@name` of the object assigned to the variable `sparky`. `set_name=` is what we call a _setter_ method.Notice the ability to NOT have to write `sparky.set_name=("Spartacus")`. Ruby has that _syntactical sugar_ that allows us to simply write `sparky.set_name = "Spartacus"` which is much easier to read.

Finally, as a good convention, Rubyists name those getter/setter methods using the same name as the instance variable they are exposing and setting. So our code will change to the following:
```ruby
# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak               # => "Sparky says arf!"
puts sparky.name                # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name                # => "Spartacus"
```
Ever more finally, this would be tedious and time consuming if we had to create these methods for every instance variable. Ruby has a shortcut way to create them using `attr_reader`, `attr_writer`, and `attr_accessor`.
```ruby
# good_dog.rb

class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
```
Use `attr_accessor` to create both getter and setter methods. Use `attr_reader` to create just a getter method. Use `attr_writer` to create just a setter method.
### Accessor Methods in Action
From inside a class, the getter method can be used to access an instance variable:
```ruby
def speak
  "#{@name} says arf!"
end
```
becomes...
```ruby
def speak
  "#{name} says arf!"
end
```
```ruby
def ssn
end
```

```ruby
# good_dog.rb

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.
```
```ruby
def change_info(n, h, w)
  name = n
  height = h
  weight = w
end

puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.
```

#### Calling Methods with Self
```ruby
def change_info(n, h, w)
  self.name = n
  self.height = h
  self.weight = w
end
```
This tells Ruby to called the setter methods instead of creating local variables. We could be consistent with this and use `self` when calling getter methods as well but it is not required.
```ruby
def info
  "#{self.name} weights #{self.weight} and is #{self.height} tall."
end
```
Now we can run the code and get was we expect:
```ruby
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.
```