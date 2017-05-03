class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting
kitty = Cat.new
# the following code works because kitty.class returns the name of kitty's class, which is Cat, then generic_greeting is called on the class. 
kitty.class.generic_greeting
