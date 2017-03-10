# Use the each_with_index method to iterate through an array
# of your creation that prints each index and value of the array

array = ["First", "Second", "Third", "Fourth", "Fifth"]

array.each_with_index do |name, index|
  puts "#{index}. #{name}"
end
