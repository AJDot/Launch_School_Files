# additional_practice.rb

# Title each exercise when run
def display_e(num)
  Kernel.puts("=> Exercise \##{num}:")
end

display_e(1)
# Answer 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end
p flintstones_hash

# Alternative Answer 1
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
index = 0
flintstones_hash = flintstones.each_with_object({}) do |name, hash|
                     hash[name] = index
                     index += 1
                   end
p flintstones_hash


display_e(2)
# Answer 2
ages = {"Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237}
sum = ages.values.sum
puts(sum)

# Alternative Answer 2
ages = {"Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237}
sum = 0
ages.each do |_, age|
  sum += age
end
puts(sum)

# Alternative Answer 2
ages = {"Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237}
sum = ages.values.inject(:+)
puts(sum)

display_e(3)
# Answer 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
young_people = ages.select do |_, value|
  value < 100
end
puts(young_people)

display_e(4)
# Answer 4
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
youngest_munster = ages.values.inject do |youngest, age|
  if age < youngest
    age
  else
    youngest
  end
end
all_youngest = ages.select {|_, age| age == youngest_munster}
puts(all_youngest)

# Alternative Answer 4
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
min_age = ages.values.sort.first
all_youngest = ages.select { |_, age| age == min_age}
puts(all_youngest)

# Alternative Answer 4
puts(ages.values.min)

display_e(5)
# Answer 5
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
index_for_Be = flintstones.index {|name| name[0..1] == 'Be'}
puts(index_for_Be)

# Alternative Answer 5
# flintstones.find_index

display_e(6)
# Answer 6
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! {|name| name[0, 3]}
puts(flintstones)

display_e(7)
# Answer 7
statement = "The Flintstones Rock"
unique_chars = statement.split('').uniq
char_count = unique_chars.each_with_object({}) do |char, hash|
               hash[char] = statement.count(char)
             end
puts(char_count)
# The solution above will count the number of spaces as well.

# Alternative Answer 7
statement = "The Flintstones Rock"
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end
puts(result)


display_e(8)
# Answer 8
# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.shift(1)
# end
puts('The output of this code will be 1 then 3.')
# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.pop(1)
# end
puts('The output of this code will be 1 then 2.')


display_e(9)
# Answer 9
def titleize(statement)
  statement.split.map {|word| word.capitalize}.join(' ')
end

words = "the flintstones rock"
words_titleized = titleize(words)
puts(words)
puts(words_titleized)

display_e(10)
# Answer 10
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, info|
  info['age_group'] = if info['age'] >= 65
                          'senior'
                      elsif info['age'] >= 18
                          'adult'
                      else
                          'kid'
                      end
end

p munsters

# Alternative Answer 10
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, info|
  info['age_group'] = case info['age']
                        when 0...18
                          'kid'
                        when 18...65
                          'adult'
                        else
                          'senior'
                        end
end

p munsters
