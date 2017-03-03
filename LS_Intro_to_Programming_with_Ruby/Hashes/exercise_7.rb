# Given the following code...

x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}
# What's the difference between the two hashes that were created?

# ANSWER
puts "The key is different."
puts "In my_hash the key is the symbol ':x'."
puts "In my_hash2 the key is the variable 'x' which points to \"hi there\"" +
     " therefore 'hi there' is the key."
