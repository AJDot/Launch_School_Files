# 1000_lights.rb

#Understand the problem
#  You have a bank of switches before you numbered from 1 to 1000. Each switch
#  is connected to exactly one light that is initially off. You walk down the
#  row of switches, and turn every one of them on. Then, you go back to the
#  beginning and toggle switches 2, 4, 6, and so on. Repeat this for switches
#  3, 6, 9, and so on, and keep going until you have been through 1000
#  repetitions of this process.

#  Write a program that determines which lights are on at the end.

#Examples / Test Cases
#  Example with 5 lights:
#
#  round 1: every light is turned on
#  round 2: lights 2 and 4 are now off; 1, 3, 5 are on
#  round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
#  round 4: lights 2 and 3 are now off; 1, 4, and 5 are on
#  round 5: lights 2, 3, and 5 are now off; 1 and 4 are on
#  The result is that 2 lights are left on, lights 1 and 4.
#
#  With 10 lights, 3 lights are left on: lights 1, 4, and 9.

#Data Structures
#  - Input:
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def flip_on_mod!(hash, mod)
  hash.each do |position, state|
    hash[position] = !hash[position] if position % mod == 0
  end
end

def switch_lights!(lights)
  1.upto(lights.size) { |round| flip_on_mod!(lights, round) }
  lights
end

def create_lights(n)
  lights = Hash.new
  1.upto(n) { |position| lights[position] = false }
  lights
end

def on_lights(lights)
  lights.keys.select { |key| lights[key] == true}
end

def off_lights(lights)
  lights.keys.select { |key| lights[key] == false }
end

def light_sets(start, stop)
  start.upto(stop) do |n|
    lights = create_lights(n)
    switch_lights!(lights)
    puts "#{n.to_s.ljust(4)} => #{on_lights(lights)}"
  end
end

puts "Lights on"
light_sets(1, 25)

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
# 1. The only lights that remain on are perfect squares because perfect squares
#  are the only numbers with an odd number of factors. Flipping the state of
#  something an odd number of times will result in the opposite state being
#  the final state after all the flipping

# Replicate the output from the description.

def list_and(array)
  if array.size == 0
    'none'
  elsif array.size == 1
    array.first
  else
    "#{array[0..-2].join(', ')} and #{array[-1]}"
  end
end

lights = create_lights(64)
switch_lights!(lights)
lights_on = on_lights(lights)
p lights_on
lights_off = off_lights(lights)
puts "lights #{list_and(lights_off)} are now off; #{list_and(lights_on)} are on."
