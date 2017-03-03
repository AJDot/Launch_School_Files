=begin
  Orange tree.
  Make an OrangeTree class that has a height method that returns
  its height and a one_year_passes method that, when called, ages
  the tree one year. Each year the tree grows taller (however much
  you think an orange tree should grow in a year), and after some
  number of years (again, your call) the tree should die. For the
  first few years, it should not produce fruit, but after a while
  it should, and I guess that older trees produce more each year
  than younger trees...whatever you think make the most sense.
  And, of course, you should be able to count_the_oranges (which
  returns the number of oranges on the tree) and pick_an_orange
  (which reduces the @orange_count by 1 and returns a string
  telling you how delicious the orange was, or else it just
  tells you that there are no more oranges to pick this year).
  Make sure any oranges you don't pick one year fall off before
  the next year.
=end

class OrangeTree
  def initialize
    @height       = 0   # Seed is planted, no height
    @age          = 0   # New tree, no age
    @orange_count = 0   # New tree, no oranges
    @alive        = true
    puts "You planted an orange tree!"
  end

  def height
    if @alive
      @height
    else
      'A dead tree is not very tall.'
    end
  end

  def count_the_oranges
    if @alive
      @orange_count
    else
      'A dead tree has no oranges.'
    end
  end

  def one_year_passes
    if @alive
      @age += 1                     # tree ages by one year
      @height = (@height + 0.4 + rand()).round                # increase height based on age
      @orange_count = 0             # oranges from last year fall off

      if @age > 12 && rand(2) > 0
        # tree dies
        @alive = false
        puts "Your tree is a billion years old in tree years and decided this was the end."
      elsif @age > 2
        add_fruit
        "This year your tree grew to #{@height}m tall," +
        " and produced #{@orange_count} oranges."
      else
        "This year your tree grew to #{@height}m tall," +
        " but is still too young to bear fruit."
      end
    else
      'The tree is still dead. No black magic here.'
    end
  end

  def pick_an_orange
    if @alive
      if @orange_count > 0
        @orange_count -= 1
        puts "You pick an orange..."
        puts "That orange was super delicious!"
      else
        puts "There are no oranges on this tree!"
      end
    else
      'A dead tree has no fruit to pick.'
    end
  end

  private
  def add_fruit
    @orange_count = (@height * (rand(6) + 7) - 25).to_i # increase oranges based on age
  end
end

my_tree = OrangeTree.new
25.times do
  puts my_tree.one_year_passes
  if my_tree.count_the_oranges % 2 == 0
    puts my_tree.pick_an_orange
  end
end
