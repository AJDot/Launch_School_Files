### Explain the relationship between classes and objects.

Classes are like the blueprint to create objects. A class outlines what an object will be able to do and what will make up the state of the object. An object represents a particular state of a class. Take this class for example:

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end
```
The creation of this class will now allow us to create `Animal` objects by using the `Animal::new` method. Doing so will call the `initialize` method with the supplied argument(s). This new object represents a particular state of the `Animal` class.

Let's instantiate our first object.
```ruby
chester = Animal.new('Chester')

puts chester # => #<Animal:0x3207090>
puts chester.class # => Animal
p chester # => #<Animal:0x3207090 @name="Chester">
```
We can see that `chester` is an instance of the `Animal` class as evident by the first 2 outputs of the above code. The last output calls `inspect` on the object and returns the class and all of the object's instance variables. These variables are what make up the state of the object.

We can make as many objects as we like and all will represent different states of the `Animal` class.
```ruby
bill = Animal.new('Bill')
fred = Animal.new('Fred')

p bill # => #<Animal:0x31fc3b0 @name="Bill">
p fred # => #<Animal:0x3236088 @name="Fred">
```
