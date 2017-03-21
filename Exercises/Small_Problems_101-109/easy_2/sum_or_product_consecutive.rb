# sum_or_product_consecutive.rb

#Understand the problem
#  - user enters a positive integer, then asks if the user wants to determine
#  - the sum or product of all numbers between 1 and the entered integer
#  - Input: a positive integer
#  - Output: the sum or product of all numbers (1..n)
#
#Examples / Test Cases
#  - >> Please enter an integer greater than 0:
#  - 5
#  - >> Enter 's' to compute the sum, 'p' to compute the product.
#  - s
#  - The sum of the integers between 1 and 5 is 15.
#  -
#  -
#  - >> Please enter an integer greater than 0:
#  - 6
#  - >> Enter 's' to compute the sum, 'p' to compute the product.
#  - p
#  - The product of the integers between 1 and 6 is 720.
#
#Data Structures
#  - Input: positive integer (n)
#  - Output: sum or product (sum, product)
#
#Algorithm / Abstraction
#  - get positive integer (n)
#  - get choice of sum or product (choice)
#  - if 's', compute sum
#  - else 'p', computer product
#  - display sum or product

# Program
def compute_sum(num)
  (1..num).reduce(:+)
end

def compute_product(num)
  (1..num).reduce(:*)
end


num = nil
loop do
  puts ">> Please enter an integer greater than 0:"
  num = gets.chomp
  break if num.to_i.to_s == num
  puts "Invalid input"
end
num = num.to_i

choice = nil
loop do
  puts ">> Enter 's' to computer the sum, 'p' to compute the product."
  choice = gets.chomp
  break if ['s', 'p'].include?(choice)
end

case choice
when 's'
  sum = compute_sum(num)
  puts "The sum of the integers between 1 and #{num} is #{sum}."
when 'p'
  product = compute_product(num)
  puts "The product of the integers between 1 and #{num} is #{product}."
else
  puts "Whatever you did... it wasn't right"
end

# Further Exploration
