# count the size of the land mass

# create a land mass with x rows and y columns
def create_world(x, y)

  world = Array.new(x)
  for row in 0..(x-1) do
    world[row] = Array.new(y)
  end

  for col in 0..(y-1)
    for row in 0..(x-1)
      world[row][col] = rand(1..10) > 6 ? 'M' : 'o'
    end
  end
  world
end

# print the world to screen
def print_world(world)
  world.each do |row|
    print row
    puts
  end
  puts
end

# calculate size of land mass starting at row x and column y
def continent_size(world, x, y)
  if x < 0 || x > world.length - 1 || y < 0 || y > world[0].length - 1
    return 0
  end
  if world[x][y] != 'M'
    # Either it's water or we already counted it,
    # but either way, we don't want to count it now.
    return 0
  end
  # First count the tile you are on
  size = 1
  world[x][y] = 'P'

  # ... then we count all of the neighboring either tiles
  # (and, of course, their neighbors by way of the recursion).
  size = size + continent_size(world, x-1, y-1)
  size = size + continent_size(world, x  , y-1)
  size = size + continent_size(world, x+1, y-1)
  size = size + continent_size(world, x-1, y  )
  size = size + continent_size(world, x+1, y  )
  size = size + continent_size(world, x-1, y+1)
  size = size + continent_size(world, x  , y+1)
  size = size + continent_size(world, x+1, y+1)
  size
end



puts 'Enter # of rows for world:'
x = gets.chomp.to_i
puts 'Enter # of columns for world:'
y = gets.chomp.to_i

# create a new world
world = create_world(x, y)
print_world(world)

puts "Set starting row for land mass count (count starts at 0):"
row = gets.chomp.to_i
puts "Set starting column for land mass count (count starts at 0):"
col = gets.chomp.to_i

puts "The size of the land mass starting at (#{row}, #{col}) is " + continent_size(world, row, col).to_s
