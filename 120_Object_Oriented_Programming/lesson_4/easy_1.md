# Exercises: Easy 1
#### Question 1
Which of the followings are object in Ruby? If they are object, how can you find out what class they belong to?

1. `true`
1. `"hello"`
1. `[1, 2, 3, "happy days"]`
1. `142`

##### Answer
All of them are objects because everything in Ruby is an object. To find out which class they belong to we can invoke the `#class` method on them.
```ruby
true.class                    # => TrueClass  
"hello".class                 # => String    
[1, 2, 3, "happy days"].class # => Array                    
142.class                     # => Integer
```

#### Question 2
If we have a `Car` class and a `Truck` class and we want to be able to `go_fast`, how can we add the ability for them to `go_fast` using the module `Speed`? How can you check if your `Car` or `Truck` can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

##### Answer
Modules must be included in a class in order for its methods to be used, like this. And we test it by invoking `go_fast` on a new instance of `Car` and `Truck`. The desired result is produced.
```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

Car.new.go_fast   # => I am a Car and going super fast!
Truck.new.go_fast # => I am a Truck and going super fast!
```

#### Question 3
In the last question we had a module called `Speed` which contained a `go_fast` method. We included this module in the `Car` class as shown below.
```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
```

When we called the `go_fast` method from an instance of the `Car` class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

##### Answer
The `go_fast` method includes `self.class` which will return the name of the class that the method is in because `self` refers to the object itself. When `go_fast` is invoked from inside the `Car` class, then `self.class` will return `Car`. If invoked from the `Truck` class, then `self.class` will return `Truck`. Because `self.class` is interpolated inside a string, `to_s` is automatically called on it.

#### Question 4
If we have a class `AngryCat` how do we create a new instance of this class?

The `AngryCat` class might look something like this:
```ruby
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
```

##### Answer
```ruby
AngryCat.new
```

#### Question 5

Which of these two classes has an instance variable and how do you know?
```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

##### Answer
`Pizza` has an instance variable because the name of the variable begins with "@".
Another way to check is to call the `@instance_variables` method on an instance of the class.
```ruby
pizza = Pizza('cheese')
pizza.instance_variables  # => [:@name]
apple = Fruit('Gala')
apple.instance_variables  # => []
```
So `Fruit` has no instance variables and `Pizza` has one instance variable (`@name`).

#### Question 6

What could we add to the class below to access the instance variable @volume?
```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```

##### Answer
We need to use attr_* depending on how we want to access the instance variable `@volume`. attr_reader, attr_writer, attr_accessor for reading, writing, and both respectively.
```ruby
class Cube
  attr_accessor :volume

  def initialize(volume)
    @volume = volume
  end
end

my_cube = Cube.new(1000)
puts my_cube.volume   # => 1000
my_cube.volume = 500
puts my_cube.volume   # => 500
```

Here are a couple more ways to do it.
```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end

my_cube = Cube.new(1000)
puts my_cube.instance_variable_get("@volume")   # => 1000
```
```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end

  def get_volume
    @volume
  end
end

my_cube = Cube.new(1000)
puts my_cube.get_volume   # => 1000
```

#### Question 7

What is the default thing that Ruby will print to the screen if you call `to_s` on an object? Where could you go to find out if you want to be sure?

##### Answer
The default "thing" that Ruby will print to the screen if you call `to_s` is the name of the class and an encoding of the object id.
To be sure, look it up on ruby-doc.org. Navigate to the `Object` class and look for the `to_s` method. There it gives this exact description.

#### Question 8

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
You can see in the `make_one_year_older` method we have used `self`. What does `self` refer to here?

##### Answer
`self` in this case refers to the instance of the class because `self` is inside an instance method. If it were called inside the class but outside an instance method, then `self` would refer to the class itself.

#### Question 9

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
In the name of the cats_count method we have used self. What does self refer to in this context?

##### Answer
Here `self` is refering to the class `Cat`. `cats_count` is a class method as specified by the use of `self.` as the prefix to the method name.

#### Question 10

If we have the class below, what would you need to call to create a new instance of this class.
```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```

##### Answer
```ruby
Bag.new('brown', 'paper')
```
The `Bag` class requires two arguments to be passed into it when a new instance is invoked. 
