def exercise(n)
  puts ""
  puts "-------------"
  puts "Exercise #{n}"
  puts "-------------"
end

exercise(1)

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
puts bob.name                # => 'bob'
bob.name = 'Robert'
puts bob.name                # => 'Robert'

exercise(2)

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end

bob = Person.new('Robert')
p bob.name                      # => 'Robert'
p bob.first_name                # => 'Robert'
p bob.last_name                 # => ''
bob.last_name = 'Smith'
p bob.name                      # => 'Robert Smith'

exercise(3)
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert')
p bob.name                      # => 'Robert'
p bob.first_name                # => 'Robert'
p bob.last_name                 # => ''
bob.last_name = 'Smith'
p bob.name                      # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name                  # => 'John'
p bob.last_name                   # => 'Adams'

exercise(4)
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name

exercise(5)
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# This code will print the string representation of the object 'bob'.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
