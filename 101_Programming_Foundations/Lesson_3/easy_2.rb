# easy_2.rb

# Title each question when run
def display_q(num)
  Kernel.puts("=> Question \##{num}:")
end

display_q(1)
# Question 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
# See if 'Spot' is present

# Answer
puts(ages.key?("Spot"))
puts(ages.fetch("Spot", false))
puts(ages.include?("Spot"))
puts(ages.member?("Spot"))

display_q(2)
# Question 2
munsters_description = "The Munsters are creepy in a good way."

# Answer 2
puts(munsters_description.capitalize!())
munsters_description = "The Munsters are creepy in a good way."
puts(munsters_description.swapcase!())
munsters_description = "The Munsters are creepy in a good way."
puts(munsters_description.downcase!())
munsters_description = "The Munsters are creepy in a good way."
puts(munsters_description.upcase!())

display_q(3)
# Question 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
# add ages for Marilyn and Spot to the existing hash

additional_ages = { "Marilyn" => 22, "Spot" => 237 }

# Answer 3
ages.merge!(additional_ages)

p ages

display_q(4)
# Question 4
# See if the name "Dino" appears in the string below:

advice = "Few things in life are as important as house training your pet dinosaur."

# Answer 4
puts(advice.match?("Dino"))

display_q(5)
# Question 5
# Show an easier way to write this array:

flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]

# Answer 5
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones

display_q(6)
# Question 6
# How can we add the family pet "Dino" to our usual array:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Answer 6
flintstones << "Dino"
p(flintstones)

display_q(7)
# Question 7
# In the previous exercise we added Dino to our array like this:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"
# We could have used either Array#concat or Array#push to add Dino to the family.

# How can we add multiple items to our array? (Dino and Hoppy)

# Answer 7
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.concat(%w(Dino Hoppy))
p(flintstones)

display_q(8)
# Question 8
# remove everything starting from "house".
advice = "Few things in life are as important as house training your pet dinosaur."

# Answer 8
puts(advice.slice!(/.*as\s/))
puts(advice)

advice = "Few things in life are as important as house training your pet dinosaur."
puts(advice.slice!(0, advice.index('house')))
puts(advice)

display_q(9)
# Question 9
# Write a one-liner to count the number of lower-case 't' characters in the following string:

statement = "The Flintstones Rock!"

# Answer 9
puts(statement.count('t'))

display_q(10)
# Question 10
# Back in the stone age (before CSS) we used spaces to align things on the
# screen. If we had a 40 character wide table of Flintstone family members, how
# could we easily center that title above the table with spaces?
#
title = "Flintstone Family Members"

# Answer 10
puts(title.center(40))
