require 'yaml'    # now yaml is in the program

def yaml_save(object, filename)
  File.open filename, 'w' do |f|
    f.write(object.to_yaml)
  end
end

def yaml_load(filename)
  yaml_string = File.read filename

  YAML::load(yaml_string)
end

test_array = ['string 1',
              ['string 2', 234, [1,2]],
              'string 3123',
              42,
              [[2,1],[4,1],[65,1],[8,1],[9,1]]
              ]

yaml_save(test_array, 'test_file.txt')

read_array = yaml_load('test_file.txt')

puts(read_array == test_array)
