# easy_1.rb

# Title each question when run
def display_q(num)
  Kernel.puts("=> Question \##{num}:")
end

def display_a(num)
  Kernel.puts("=> \##{num}.")
end

display_q(1)
# Question 1
# What would you expect the code below to print out?
#
# numbers = [1, 2, 2, 3]
# numbers.uniq
#
# puts numbers

# Answer 1
puts("The output will be [1, 2, 2, 4] with each number printed on its own line.")

display_q(2)
# Question 2
# Describe the difference between ! and ? in Ruby. And explain what would
# happen in the following scenarios:
#
# what is != and where should you use it?
# put ! before something, like !user_name
# put ! after something, like words.uniq!
# put ? before something
# put ? after something
# put !! before something, like !!user_name

# Answer 2
puts("'!' is the 'not' operator.")
puts("'?' part of the ternary operator '? :'.")
puts("1. != means 'does not equal'. It is a conditional")
puts("2. This will return the oppposite of the Boolean value that the variable would give.")
puts("3. This will mean that uniq will now modify the caller but it is only a convention in naming, not actually Ruby syntax.")
puts("4. This will return the string version if a variable name when the name is one character.")
puts("5. This would mean the method will test something and return true/false.")
puts("6. This will turn a variable into its Boolean value")

display_q(3)
# Question 3
# Replace the word "important" with "urgent" in this string:
#
advice = "Few things in life are as important as house training your pet dinosaur."

# Answer 3
advice.sub!("important", "urgent")
puts(advice)

display_q(4)
# Question 4
# The Ruby Array class has several methods for removing items from the array.
# Two of them have very similar names. Let's see how they differ:
#
# numbers = [1, 2, 3, 4, 5]
# What do the following method calls do (assume we reset numbers to the original
#   array between method calls)?
#
# numbers.delete_at(1)
# numbers.delete(1)

# Answer 4
puts("numbers.delete_at(1) will delete the object in position 1 which is the 2. This mutates numbers.")
puts("The return value is 2.")
puts("numbers.delete(1) will delete any 1 in the array. This mutates numbers")
puts("The return value is 1.")

numbers = [1, 2, 3, 4, 5]
p numbers
numbers.delete_at(1)
p (numbers)
numbers = [1, 2, 3, 4, 5]
numbers.delete(1)
p (numbers)

display_q(5)
# Question 5
# Programmatically determine if 42 lies between 10 and 100.
#
# hint: Use Ruby's range object in your solution.

# Answer 5
if (10..100).cover?(42)
  puts("True!")
else
  puts("False!")
end

display_q(6)
# Question 6
# Starting with the string:
#
famous_words = "seven years ago..."
# show two different ways to put the expected "Four score and " in front of it.

# Answer 6
puts("Four score and #{famous_words}")
puts("Four score and " + famous_words)
puts("Four score and " << famous_words)
puts(famous_words.prepend("Four score and "))

display_q(7)
# Question 7

def add_eight(number)
  number + 8
end

number = 2

how_deep = "add_eight(add_eight(add_eight(add_eight(add_eight(number)))))"

eval(how_deep)

puts("The result will be 42.")
puts(eval(how_deep))

display_q(8)
# Question 8

array = ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]

# Make this into an un-nested array.

# Answer 8

array.flatten!()

p array

display_q(9)
# Question 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
# Turn this into an array containing only two elements:
# Barney's name and Barney's number

# Answer 9
p flintstones.assoc("Barney")
