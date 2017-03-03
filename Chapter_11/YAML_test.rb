require 'yaml'    # now yaml is in the program

test_array = ['string 1',
              ['string 2', 234, [1,2]],
              'string 3123',
              42,
              '42',
              true,
              'true',
              ]

# create YAML string from Ruby array
test_string = test_array.to_yaml

filename = 'test_file.txt'

# write YAML string to file
File.open filename, 'w' do |f|
  f.write test_string
end

# get file contents
read_string = File.read filename

# convert file contents back to array using YAML
read_array = YAML::load read_string

puts(read_string == test_string)
puts(read_array == test_array)
