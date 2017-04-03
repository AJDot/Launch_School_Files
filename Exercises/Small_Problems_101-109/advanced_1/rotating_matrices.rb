# rotating_matrices.rb

#Understand the problem
# A 90-degree rotation of a matrix produces a new matrix in which each side of
# the matrix is rotated clockwise by 90 degrees. For example, the 90-degree
# rotation of the matrix shown above is:
#
# 3  4  1
# 9  7  5
# 6  2  8
# A 90 degree rotation of a non-square matrix is similar. For example, the
# rotation of:
#
# 3  4  1
# 9  7  5
# is:
#
# 9  3
# 7  4
# 5  1
# Write a method that takes an arbitrary matrix and rotates it 90 degrees
# clockwise as shown above.



#Examples / Test Cases
# matrix1 = [
#   [1, 5, 8],
#   [4, 7, 2],
#   [3, 9, 6]
# ]
#
# matrix2 = [
#   [3, 7, 4, 2],
#   [5, 1, 0, 8]
# ]
#
# new_matrix1 = rotate90(matrix1)
# new_matrix2 = rotate90(matrix2)
# new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))
#
# p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
# p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
# p new_matrix3 == matrix2

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
def rotate90(matrix)
  rows = matrix.length
  columns = matrix[0].length
  result = []
  (0...columns).each do |col_index|
    new_row = (1..rows).map { |row_index| matrix[rows - row_index][col_index] }
    result << new_row
  end
  result
end

matrix1 = [
  [1, 2],
  [3, 4],
  [5, 6]
]

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90(matrix1)
new_matrix2 = rotate90(matrix2)
new_matrix3 = rotate90(rotate90(rotate90(rotate90(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def rotate90_LS(matrix)
  rows = matrix.length
  columns = matrix[0].length
  result = []
  (0...columns).each do |col_index|
    new_row = (0...rows).map { |row_index| matrix[row_index][col_index] }
    result << new_row.reverse
  end
  result
end

matrix1 = [
  [1, 2],
  [3, 4],
  [5, 6]
]

matrix1 = [
  [1, 5, 8],
  [4, 7, 2],
  [3, 9, 6]
]

matrix2 = [
  [3, 7, 4, 2],
  [5, 1, 0, 8]
]

new_matrix1 = rotate90_LS(matrix1)
new_matrix2 = rotate90_LS(matrix2)
new_matrix3 = rotate90_LS(rotate90_LS(rotate90_LS(rotate90_LS(matrix2))))

p new_matrix1 == [[3, 4, 1], [9, 7, 5], [6, 2, 8]]
p new_matrix2 == [[5, 3], [1, 7], [0, 4], [8, 2]]
p new_matrix3 == matrix2

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
def rotate(matrix, angle=90)
  return rotate90(matrix) if angle < 180
  rotate(rotate90(matrix), angle - 90)
end
p matrix1
p rotate(matrix1, 90)
p rotate(matrix1, 110)
p rotate(matrix1, 180)
p rotate(matrix1, 190)
