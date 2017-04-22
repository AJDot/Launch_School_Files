def exercise(n)
  puts ""
  puts "-------------"
  puts "Exercise #{n}"
  puts "-------------"
end

exercise(1)
# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# teddy = Dog.new
# puts teddy.speak
# puts teddy.swim

# class Bulldog < Dog
#   def swim
#     "can't swim!"
#   end
# end

# karl = Bulldog.new
# puts karl.speak
# puts karl.swim

exercise(2)
class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run
# pete.speak          # => 'NoMethodError'

puts kitty.run
puts kitty.speak
# puts kitty.fetch    # => 'NoMethodError'

puts dave.speak

puts bud.run
puts bud.swim

exercise(3)
puts "      Pet"
puts "      |run |"
puts "      |jump|"
puts "     /   \\ "
puts "   Dog   Cat"
puts "  |speak| |speak|"
puts "  |fetch|"
puts "  |swim |"
puts "   /"
puts " Bulldog"
puts " |swim|"

exercise(4)
# The method lookup path is the ordered list the Ruby uses to search for a method. This is important when a method is defined in multiple locations (like the #to_s method). The method lookup path will determine which definition will be used.