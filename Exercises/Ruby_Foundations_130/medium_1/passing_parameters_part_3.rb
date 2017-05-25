items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

puts '--- 1 ---'
gather(items) do |*three, one|
  puts three.join(', ')
  puts one
end

puts '--- 2 ---'
gather(items) do |one, *two, last|
  puts one
  puts two.join(', ')
  puts last
end

puts '--- 3 ---'
gather(items) do |one, *three|
  puts one
  puts three.join(', ')
end

puts '--- 4 ---'
gather(items) do |one, two, three, four|
  puts "#{one}, #{two}, #{three}, and #{four}"
end

