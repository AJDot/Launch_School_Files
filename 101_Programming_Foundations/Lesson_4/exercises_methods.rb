# exercises_methods.rb

# Title each exercise when run
def display_e(num)
  Kernel.puts("=> Exercise \##{num}:")
end

display_e(1)
# Answer 2
puts("[1, 2, 3]")

display_e(2)
# Answer 2
puts("count looks at the truthiness of the return value. It adds 1 to the count
  for every block return that is truthy")
puts("We find this out by looking at the Enumerable\#count documentation.")
display_e(3)
# Answer 3
puts("Return: [1, 2, 3]")
puts("reject will return all elements that make the block not true")
puts("In this case, puts will always return nil which is a not true value.")
display_e(4)
# Answer 4
puts("'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}")
puts("The first index of value is the first letter of the word.")
puts("This is assigned as the key and the entire word is the value.")
puts("The return value will then be the newly created hash.")
display_e(5)
# Answer 5
puts("hash.shift will destructively remove the first key-value of the hash (a: 'ant').")
puts("This will return the array [:a, 'ant']")
puts("The original hash is now hash = {b: 'bear'}")
puts('To find this out, go to Hash#shift in the docs.')
display_e(6)
# Answer 6
puts('11')
puts('#pop will destructively remove the last element in an array and return that element')
puts('Therefore the #size of this return is 11, the length of the word caterpillar.')
display_e(7)
# Answer 7
puts('The block\'s return value is true for the 1st element. Then it stops iterating since there
  is no need to evaluate the remaining items.' )
puts('Determine this by viewing Enumerable#any? in the docs.')
puts('The output of the code will be 1 puts')
puts('Then it will return true since at least one block iteration returned true.')
display_e(8)
# Answer 8
puts('#take(n) will select the first n element from the array')
puts('it is not destructive since the docs indicate that it returns a new_ary')
puts('Look at Array#take to find out. I tested it in irb to find out.')
display_e(9)
# Answer 9
puts('[nil, "bear"]')
puts('"ant".size is not greater than 3 so the if statement will not run. Therefore the return value will be nil')
puts('"bear".size is greater than 3 so the return will be "bear"')
display_e(10)
# Answer 10
puts('[1, nil, nil]')
puts('1 is not greater than 1 so the else statement will execute and return the number 1')
puts('2 and 3 are greater than 1 so they will each print the number. The return value of puts is nil
  so the return value of the block is nil.')
