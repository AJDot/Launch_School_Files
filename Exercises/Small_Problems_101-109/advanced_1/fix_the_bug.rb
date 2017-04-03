# fix_the_bug.rb

#Understand the problem
# The following code:

# def my_method(array)
#   if array.empty?
#     []
#   elsif
#     array.map do |value|
#       value * value
#     end
#   else
#     [7 * array.first]
#   end
# end
#
# p my_method([])
# p my_method([3])
# p my_method([3, 4])
# p my_method([5, 6, 7])
# is expected to print:
#
# []
# [21]
# [9, 16]
# [25, 36, 49]
# However, it does not. Obviously, there is a bug. Find and fix the bug, then
# explain why the buggy program printed the results it did.

#Examples / Test Cases
# Example output


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
def my_method(array)
  if array.empty?
    []
  elsif array.length > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([])
p my_method([3])
p my_method([3, 4])
p my_method([5, 6, 7])

# []
# [21]
# [9, 16]
# [25, 36, 49]

# There was an elsif in the logic that didn't have a condition. I inserted the condition of the array having to be greater than one which fixed the code.
# Without this condition, code will look on the next line for the conditional. This would be the return of #map which is always truthy. Therefore the elsif code will run, but since the #map method was used as the conditional, there is no code to actually evaluate which means the return value is nil.

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
