# Public, Private, and Protected Instance Methods

The state of an object may be accessed or changed if the class allows it. Instance variables may be exposed to the user if necessary through the use of public instance methods (often called getter & setter methods) which may be called from inside or outside the class. Private methods may only be called from within the object itself. Protected methods may be called from with the object itself and from within other instances of the same class. The default instance method is public.
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
## Getter Methods
With the code above, `@name` may be accessed from outside of the method using `<object>.name`. Note the use of the reserved word `public`. In this situation it is not needed since the default is `public`. `@age` may only be accessed from within the object. `@mood` may be accessed from within any object of the same class. The below code demonstrates each one of these cases.
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


puts chester.name # => Chester

puts bill.age # => NoMethodError
puts bill.compare_age fred # => NoMethodError

puts fred.mood # => NoMethodError
puts fred.compare_mood bill # => true
```
In the order of the 5 outputs:
1. `@name` _is_ accessible outside of the class because its getter method is `public`.
2. `@age` _is not_ accessible outside of the object because its getter method is `private`.
3. `@age` _is not_ accessible by other instances of the same class because its getter method is `private`.
4. `@mood` _is not_ accessible outside of the object because its getter method is `protected`.
5. `@mood` _is_ accessible by other instances of the same class because its getter method is `protected`.

In this way, the user interface can be composed of which only what the user needs. At the same time, this provides a level of security for sensitive data and methods.

## Setter Methods
```ruby
class Animal
  attr_reader :name, :age, :mood

  def initialize(name, age, mood)
    @name = name
    @age = age
    @mood = mood
  end

  public

  def change_name=(name)
    @name = name
  end

  private

  def change_age=(age)
    @age = age
  end

  protected

  def change_mood=(mood)
    @mood = mood
  end
end


chester.change_name = "Wilbur"
puts chester.name # => Wilbur

bill.change_age = 17   # => NoMethodError
puts bill.age # => 13

fred.change_mood = "happy" # => NoMethodError
```
In the above code we are attempting to change the value of each instance variable but only did this successfully for `@name`. This is because `#change_name` is the only setter method that is `public`. `#change_age` is `protected` and `#change_mood` is `private`. So how can we change these values without having direct access to these methods?

Answer: give access to these method through other methods.
```ruby
class Animal
  attr_reader :name, :age, :mood

  def initialize(name, age, mood)
    @name = name
    @age = age
    @mood = mood
  end

  public

  def change_name=(name)
    @name = name
  end

  def modify_age=(new_age)
    change_age(new_age) if new_age > age
  end

  def modify_mood=(new_mood)
    change_mood(new_mood) if %w(happy sad frumpy dumpy).include? new_mood
  end

  private

  def change_age(new_age)
    @age = new_age
  end

  protected

  def change_mood(mood)
    @mood = mood
  end
end


chester.name # => Wilbur

bill.modify_age = 17
bill.age # => 17

```
Changing the name works just the same since the method was already public but the other two needed some adjustments.

To use the `private` method `#change_age` we had to remove the `=` symbol from its name and create a `public` method that would access it. `modify_age=` was created. It includes a small bit of logic that requires the new age value to be greater than the current value. By making `change_age` private this allows the user to only change the name if it follows the logic we implemented.

A similar bit of logic is used to change the mood as well. Here, the new mood must be one of the four moods listed in the method `#modify_mood=`.

So private and protected methods allow us to implement additional logic to increase the privacy of the data and robustness of the program.