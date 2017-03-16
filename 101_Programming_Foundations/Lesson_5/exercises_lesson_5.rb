# exercises_lesson_5.rb

# Title each exercise when run
def display_e(num)
  Kernel.puts("=> Exercise \##{num}:")
end

display_e(1)
# Exercise 1
arr = ['10', '11', '9', '7', '8']

sorted_arr = arr.sort do |a, b|
  b.to_i <=> a.to_i
end

p arr
p sorted_arr

display_e(2)
# Exercise 2
books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

sorted_books = books.sort_by do |a, b|
  a[:published].to_i
end

p books
p sorted_books

display_e(3)
# Exercise 3
arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
puts(arr1[2][1][3])
arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
puts(arr2[1][:third][0])
arr3 = [['abc'], ['def'], {third: ['ghi']}]
puts(arr3[2][:third][0][0])
hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
puts(hsh1['b'][1])
hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
puts(hsh2[:third].keys[0])

display_e(4)
# Exercise 4
arr1 = [1, [2, 3], 4]
arr1[1][1] = 4
p(arr1)
arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
arr2[2] = 4
p(arr2)
hsh1 = {first: [1, 2, [3]]}
hsh1[:first][2][0] = 4
p(hsh1)
hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
hsh2[['a']][:a][2] = 4
p(hsh2)

display_e(5)
# Exercise 5
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

total_male_age = 0

munsters.each_value do |details|
  total_male_age += details['age'] if details['gender'] == 'male'
end

p(total_male_age)

display_e(6)
# Exercise 6
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each_pair do |name, info|
  puts("#{name} is a #{info['age']}-year-old #{info['gender']}.")
end

display_e(7)
# Exercise 7
a = 2
b = [5, 8]
arr = [a, b]

arr[0] += 2
arr[1][0] -= a

# Without running the code, I think a = 2 and b = [3, 8]
puts("a = #{a} and b = #{b}")
# I am correct.

display_e(8)
# Exercise 8
hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# My solution
hsh.each_pair do |_, value|
  value.each do |word|
    vowels = word.chars.select {|letter| letter =~ /[aeiou]/ }
    puts("Vowels in the word '#{word}': #{vowels}")
  end
end

# Your solution
vowels = 'aeiou'
hsh.each_pair do |_, value|
  value.each do |word|
    word.chars.each do |char|
      puts char if vowels.include?(char)
    end
  end
end

display_e(9)
# Exercise 9
arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
sorted_arr = arr.map do |sub_arr|
  sub_arr.sort do |a, b|
    b <=> a
  end
end

p(sorted_arr)


display_e(10)
# Exercise 10
arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# My solution
incremented_arr = arr.map do |hash|
  hash = hash.dup
  hash.each do |key, _|
    hash[key] += 1
  end
end
p(arr)
p(incremented_arr)

# Your solution
incremented_arr = arr.map do |hash|
  incremented_hash = {}
  hash.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end

p(arr)
p(incremented_arr)

display_e(11)
# Exercise 11
arr = [[2], [3, 5, 7], [9], [11, 13, 15]]
multiples_of_3 = arr.map do |sub_arr|
  sub_arr.select do |num|
    num % 3 == 0
  end
end

p(arr)
p(multiples_of_3)

display_e(12)
# Exercise 12
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

new_hash = {}
arr.each do |sub_arr|
  new_hash[sub_arr[0]] = sub_arr[1]
end

p(arr)
p(new_hash)

display_e(13)
# Exercise 13
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
odd_sort = arr.sort_by do |sub_arr|
  sub_arr.select {|num| num.odd?}
end

p(arr)
p(odd_sort)

display_e(14)
# Exercise 14
hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

colors_and_sizes = hsh.map do |_, info|
  if info[:type] == 'fruit'
    info[:colors].map {|color| color.capitalize}
  elsif info[:type] == 'vegetable'
    info[:size].upcase
  end
end

p(colors_and_sizes)

display_e(15)
# Exercise 15
arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
# My solution
even_hashes = arr.select do |hash|
  hash.values.flatten.all? { |value| value.even?}
end
p(even_hashes)

# Your solution
even_hashes = arr.select do |hash|
  hash.all? do |_, value|
    value.all? do |num|
      num.even?
    end
  end
end
p(even_hashes)

display_e(16)
# Exercise 16
def new_UUID
  uuid = ''
  32.times do |num|
    uuid << if [8, 12, 16, 20].include?(num)
              "-" + rand(0...16).to_s(16)
            else
              rand(0...16).to_s(16)
            end
  end
  uuid
end

puts("-----5 UUIDs-----".center(32))
puts(new_UUID)
puts(new_UUID)
puts(new_UUID)
puts(new_UUID)
puts(new_UUID)
