=begin
  Make a cheat method that allows the user to set the value of the die.
=end

class Die
  def initialize
    roll
  end

  def roll
    @number_showing = 1 + rand(6)
  end

  def showing
    @number_showing
  end

  def cheat n
    if n.integer? == true && n >= 1 && n <= 6
      @number_showing = n
    else
      puts "#{n} is not on the die!"
    end
  end
end

die = Die.new

#puts die.showing
puts die.roll
#puts die.showing
die.cheat 4
puts die.showing
