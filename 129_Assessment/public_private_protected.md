### Public, Private, and Protected Instance Methods

The state of an object may be accessed or changed if the class allows it. Instance variables may be exposed to the user if necessary through the use of public instance methods (often called getter & setter methods) which may be called from inside or outside the class. Private methods may only be called from within the object itself. Protected methods may be called by the object itself and by other instances of the same class. The default instance method is public.
```ruby
class Animal
  def initialize(name, age, mood)
    @name = name
    @age = age
    @mood = mood
  end

  public

  def name
    @name
  end

  private

  def age
    @age
  end

  protected

  def mood
    @mood
  end
end
```
With the code above, `@name` may be accessed from outside of the method using `<object>.name`. `@age` may only be accessed from within the object. `@mood` may be accessed from within any object of the same class. The below code demonstrates each on of these cases.
```ruby
class Animal
  def initialize(name, age, mood)
    @name = name
    @age = age
    @mood = mood
  end

  public

  def name
    @name
  end

  def compare_mood(other)
    mood == other.mood
  end

  def compare_age(other)
    age == other.age
  end

  private

  def age
    @age
  end

  protected

  def mood
    @mood
  end
end

chester = Animal.new('Chester',15 , 'frumpy')
bill = Animal.new('Bill', 13, 'dumpy')
fred = Animal.new('Fred', 13, 'dumpy')

puts chester.name # => Chester
puts bill.age # => NoMethodError
puts bill.compare_age fred # => NoMethodError
puts fred.mood # => NoMethodError
puts fred.compare_mood bill # => true
```
In the order of the 5 outputs:
1. `@name` is accessible outside of the class because its getter method is `public`.
2. `@age` is _not_ accessible outside of the object because its getter method is `private`.
3. `@age` is _not_ accessible by other instances of the same class because its getter method is `private`.
4. `@mood` is _not_ accessible outside of the object because its getter method is `protected`.
5. `@mood` is accessible by other instances of the same class because its getter method is `protected`.

In this way, the user interface can be composed of which only what the user needs. At the same time, this provides a level of security for sensitive data and methods.