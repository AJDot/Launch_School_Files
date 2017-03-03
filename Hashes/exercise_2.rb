# Look at Ruby's merge method. Notice that it has two versions. What is the
# difference between merge and merge!? Write a program that uses both and
# illustrate the differences.

# ANSWER

puts "merge will return a new hash with the content of the first & second" +
     " hashes put together."
puts
puts "merge! will add the contents of the second hash to the first hash." +
     " This is a destructive process."
puts

hash_old = {apple: 3, banana: 4, lemon: 3, chocolate: 17}
hash_new = {grape: 87, orange: 6, lime: 2}

puts "hash_old = #{hash_old}"
puts "hash_new = #{hash_new}"

puts "Using merge: "
puts "  #{hash_old.merge(hash_new)}"
puts "hash_old = #{hash_old}"
puts "hash_new = #{hash_new}"
puts
puts "Using merge!: "
puts "  #{hash_old.merge!(hash_new)}"
puts "hash_old = #{hash_old}"
puts "hash_new = #{hash_new}"
