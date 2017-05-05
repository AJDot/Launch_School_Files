# class Person
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
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
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
#   end
#
#   private
#
#   def gait
#     "saunters"
#   end
# end
#
# class Cheetah
#   attr_reader :name
#
#   def initialize(name)
#     @name = name
#   end
#
#   private
#
#   def gait
#     "runs"
#   end
# end
# You need to modify the code so that this works:
#
# mike = Person.new("Mike")
# mike.walk
# # => "Mike strolls forward"
#
# kitty = Cat.new("Kitty")
# kitty.walk
# # => "Kitty saunters forward"
#
# flash = Cheetah.new("Flash")
# flash.walk
# # => "Flash runs forward"
# You are only allowed to write one new method to do this
module Walk
  def walk
    "#{name} #{gait} forward"
  end
end


class Person
  include Walk

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walk

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walk

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
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
