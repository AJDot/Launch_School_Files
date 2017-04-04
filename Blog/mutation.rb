array1 = %w[my name is alex.]
array2 = []
array1.each { |value| array2 << value }
array1.each { |value| value.upcase! }
puts "array1: #{array1}"
puts "array2: #{array2}"

array1 = %w[my name is alex.]
array2 = []
array1.each { |value| array2 << value }
array1.map! { |value| value.upcase }
puts "array1: #{array1}"
puts "array2: #{array2}"
