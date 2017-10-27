# Uses of self
## What are two ways self can be used inside a class?

## call setter method
The first was `self` can be used is to call a setter method from within an instance method. If `self` is not used then Ruby will think you are trying to assign a local variable.

Example
```ruby
class Animal
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def change_info(new_name, new_age)
    name = new_name
    age = new_age
  end

end


chester.name    # => Chester
chester.age     # => 15
```
In the above code, `#change_info` did not do the job as intend because Ruby assigned two local variables (`name` and `age`) to the new values.

```ruby
class Animal
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def change_info(new_name, new_age)
    self.name = new_name
    self.age = new_age
  end

end


chester.name    # => Bill
chester.age     # => 16
```
Now the `#change_info` method is calling the setter methods using `self.` which then change the values fo the instance variables.

***

## define class method
Theh second was to use `self` is to define class methods. These are methods that do not pertain to the state of a particular object of the class, but to the class itself.
```ruby
class Animal
  attr_accessor :name, :age

  @@total_animals = 0

  def self.total_animals
    @@total_animals
  end

  def initialize
    @@total_animals += 1
  end
end

Animal.total_animals    # => 0
Animal.new
Animal.total_animals    # => 1
Animal.new
Animal.total_animals    # => 2
```
Inside a class, define a method with `self.` prepended and it will become a class method. This can be used to keep track to the state of the class as a whole, such as the number of object instantiated from that class.

## Summary
`self` is used in two ways.
1. Access setter methods: In this case, when `self` is used inside an instance method, it refers to the object that is calling that method. Up above, `self.name=` was the same as `chester.name=`
2. Define class methods: In this case, `self` is refering to the class itself. In the second example, `self.total_animals` is the same as saying `Animal.total_animals`.