# Now that we have a Walkable module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.

# We need a new class Noble that shows the title and name when walk is called:
# module Walk
#   def walk
#     "#{self} #{gait} forward"
#   end
# end
#
# class Person
#   include Walk
#
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
#   end
#
#   def to_s
#     name
#   end
#
#   private
#
#   def gait
#     "strolls"
#   end
# end
#
# class Cat
#   include Walk
#
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
#   end
#
#   def to_s
#     name
#   end
#   private
#
#   def gait
#     "saunters"
#   end
# end
#
# class Cheetah
#   include Walk
#
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
#   end
#   def to_s
#     name
#   end
#
#   private
#
#   def gait
#     "runs"
#   end
# end
#
# class Noble
#   include Walk
#
#   attr_reader :name, :title
#
#   def initialize(name, title)
#     @name = name
#     @title = title
#   end
#
#   def gait
#     'struts'
#   end
#
#   def to_s
#     "#{title} #{name}"
#   end
# end
#
# mike = Person.new("Mike")
# puts mike.walk
# # => "Mike strolls forward"
#
# kitty = Cat.new("Kitty")
# puts kitty.walk
# # => "Kitty saunters forward"
#
# flash = Cheetah.new("Flash")
# puts flash.walk
# # => "Flash runs forward"
#
# byron = Noble.new("Byron", "Lord")
# p byron.walk
# # => "Lord Byron struts forward"
# # We must have access to both name and title because they are needed for other purposes that we aren't showing here.
#
# puts byron.name
# # => "Byron"
# puts byron.title
# => "Lord"

# Further Exploration
puts ""
puts "FURTHER EXPLORATION"
puts ""

module Walk
  def walk
    "#{self} #{gait} forward"
  end
end

class Animal
  include Walk

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def to_s
    name
  end
end

class Person < Animal
  private

  def gait
    "strolls"
  end
end

class Cat < Animal
  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  private

  def gait
    "runs"
  end
end

class Noble < Person
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  private

  def gait
    'struts'
  end

  def to_s
    "#{title} #{super}"
  end
end

mike = Person.new("Mike")
puts mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
puts kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
puts flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
puts byron.walk
# => "Lord Byron struts forward"
