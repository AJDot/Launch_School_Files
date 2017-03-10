# Can hash values be arrays? Can you have an array of hashes? (give examples)

# ANSWER
# Yes and yes

# Arrays as hash values
hash_with_arrays = {names: ["Alex", "Ale", "Al", "A", "JDot"],
                    types: ["super cool", "super short"]}

# Array of hashes
arr_of_hashes = [{name: "Alex", type: "super cool"},
                 {name: "Jasmine", type: "super short"}]

p hash_with_arrays[:names]
p arr_of_hashes[0]
