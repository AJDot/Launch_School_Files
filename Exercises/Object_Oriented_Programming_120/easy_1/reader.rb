class Cat
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def greeting
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greeting
