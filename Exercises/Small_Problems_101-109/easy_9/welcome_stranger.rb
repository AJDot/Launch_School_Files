# welcome_stranger.rb

#Understand the problem
#  Create a method that takes 2 arguments, an array and a hash. The array will
#  contain 2 or more elements that, when combined with adjoining spaces, will
#  produce a person's name. The hash will contain two keys, :title and
#  :occupation, and the appropriate values. Your method should return a
#  greeting that uses the person's full name, and mentions the person's title.
#
#Examples / Test Cases
#  greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
#  => Hello, John Q Doe! Nice to have a Master Plumber around.

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
def prompt(msg)
  puts "=> #{msg}"
end
def greetings(name, job)
  prompt "Hello, #{name.join(' ')}! Nice to have a #{job[:title]} #{job[:occupation]} around."
end

greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

def greetings_further(name, job)
  prompt "Hello, #{name.join(' ')}! Nice to have a #{job[:title]} " +
         "#{job[:occupation]} around."
end

greetings_further(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
