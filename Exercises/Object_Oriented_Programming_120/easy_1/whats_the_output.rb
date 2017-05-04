class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# ANSWER
# Fluffy => puts fluffy.name is calling to_s on the variable @name.
# My name is FLUFFY => puts fluffy is calling to_s on fluffy. This mutates @name in place.
# FLUFFY => the last line mutated the caller in place which means name was changed along with @name
# FLUFFY
# class Pet
#   attr_reader :name
#
#   def initialize(name)
#     @name = name.to_s
#   end
#
#   def to_s
#     "My name is #{@name.upcase}."
#   end
# end
# 
# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

# Further Exploration
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# ANSWER
# '42' => @name is a string, name.to_s
# My name is 42. => @name.upcase! does not throw and error because @name was converted to a string on the last line.
# '42' => still a string
# 43 => name outside of the class is a variable which is now 43
