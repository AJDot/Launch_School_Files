=begin
  Interactive baby dragon.
  Write a program that lets you enter commands such as feed and walk and
  calls those methods on your dragon. Of course, since you are inputting
  just strings, you will need some sort of method dispatch, where your
  program checks which string was entered and then calls the appropriate
  method.
=end

# Create a dragon and take care of it

class Dragon

  def initialize name
    @name = name
    @asleep = false
    @stuff_in_belly     = 10  # He's full.
    @stuff_in_intestine =  0  # He doesn't need to go.

    puts "#{name} is born."
  end

  # now all methods are private except for this method dispatch
  # so all the user can do is start this dispatch.
  def method_dispatch
    while true
      puts "Do something (feed, toss, walk, put to bed, rock)"
      action = gets.chomp
      case action
      when 'feed'
        feed
      when 'toss'
        toss
      when 'walk'
        walk
      when 'put to bed'
        put_to_bed
      when 'rock'
        rock
      when 'quit', 'exit', 'stop'
        exit
      else
        puts "That is not a dragon-approved action!"
      end
    end
  end

  private

  def feed
    puts "You feed #{@name}."
    @stuff_in_belly = 10
    passage_of_time
  end

  def walk
    puts "You walk #{@name}."
    @stuff_in_intestine = 0
    passage_of_time
  end

  def put_to_bed
    puts "You put #{@name} to bed."
    @asleep = true
    3.times do
      if @asleep
        passage_of_time
      end
      if @asleep
        puts "#{@name} snores, filling the room with smoke."
      end
    end
    if @asleep
      @asleep = false
      puts "#{@name} wake up slowly."
    end
  end

  def toss
    puts "You toss #{@name} up into the air."
    puts 'He giggles, which singes your eyebrows.'
    passage_of_time
  end

  def rock
    puts "You rock #{@name} gently."
    @asleep = true
    puts 'He briefly dozes off...'
    passage_of_time
    if @asleep
      @asleep = false
      puts '...but wakes when you stop.'
    end
  end

  # "private" means that the methods defined here are
  # methods internal to the object.  (You can feed your
  # dragon, but you can't ask him whether he's hungry.)
  def hungry?
    # Method names can end with "?".
    # Usually, we do this only if the method
    # returns true or false, like this:
    @stuff_in_belly <= 2
  end

  def poopy?
    @stuff_in_intestine >= 8
  end

  def passage_of_time
    if @stuff_in_belly > 0
      # Move food from belly to intestine.
      @stuff_in_belly       = @stuff_in_belly     - 1
      @stuff_in_intestine   = @stuff_in_intestine + 1
    else  # => Our dragon is starving!
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts "#{@name} is starving! In desperation, he ate YOU!"
      exit  # This quite the program.
    end
    if @stuff_in_intestine >= 10
      @stuff_in_intestine = 0
      puts "Whoops!  #{@name} had an accident..."
    end
    if hungry?
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts "#{@name}'s stomach grumbles..."
    end
    if poopy?
      if @asleep
        @asleep = false
        puts 'He wakes up suddenly!'
      end
      puts "#{@name} does the potty dance..."
    end
  end
end

puts "Name your dragon!"
name = gets.chomp
pet = Dragon.new name
pet.method_dispatch
