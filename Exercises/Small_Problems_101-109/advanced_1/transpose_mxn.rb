# transpose_mxn.rb

#Understand the problem
# A 3 x 3 matrix can be represented by an Array of Arrays in which the main
# Array and all of the sub-Arrays has 3 elements. For example:

# 1  5  8
# 4  7  2
# 3  9  6
# can be described by the Array of Arrays:
#
# matrix = [
#   [1, 5, 8],
#   [4, 7, 2],
#   [3, 9, 6]
# ]

# The transpose of a 3 x 3 matrix is the matrix that results from exchanging
# the columns and rows of the original matrix. For example, the transposition
# of the array shown above is:
#
# 1  4  3
# 5  7  9
# 8  2  6

# Write a method that takes a 3 x 3 matrix in Array of Arrays format and
# returns the transpose of the original matrix. Note that there is a
# Array#transpose method that does this -- you may not use it for this
# exercise. You also are not allowed to use the Matrix class from the standard
# library. Your task is to do this yourself.

# Take care not to modify the original matrix: you must produce a new matrix
# and leave the original matrix unchanged.

#Examples / Test Cases
# matrix = [
#   [1, 5, 8],
#   [4, 7, 2],
#   [3, 9, 6]
# ]
#
# new_matrix = transpose(matrix)
#
# p new_matrix == [[1, 4, 3], [5, 7, 9], [8, 2, 6]]
# p matrix == [[1, 5, 8], [4, 7, 2], [3, 9, 6]]

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
require 'pry'
def transpose(matrix)
  old_rows = matrix.length
  old_columns = matrix[0].length
  result = []
  (0...old_columns).each do |col_index|
    new_row = (0...old_rows).map { |row_index| matrix[row_index][col_index]}
    result << new_row
  end
  result
end

puts transpose([[1, 2, 3, 4]]) == [[1], [2], [3], [4]]
puts transpose([[1], [2], [3], [4]]) == [[1, 2, 3, 4]]
puts transpose([[1, 2, 3, 4, 5], [4, 3, 2, 1, 0], [3, 7, 8, 6, 2]]) ==
  [[1, 4, 3], [2, 3, 7], [3, 2, 8], [4, 1, 6], [5, 0, 2]]
puts transpose([[1]]) == [[1]]

puts "\n-------------------"
puts "Transpose in Place"
puts "For Square Matrices"
puts "-------------------"

def transpose!(matrix)
  old_rows = matrix.length
  old_columns = matrix[0].length
  (0...old_columns).each do |col_index|
    (0...old_rows).each do |row_index|
      matrix[col_index][row_index] = matrix[row_index][col_index]
    end
  end
end

matrix = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]
transpose!(matrix)
puts matrix == transpose(matrix)
