def remove_vowel(array)
  array.map do |element|
    # element.split('').select { |char| char =~ /[^aeiou]/ }.join
    element.delete('aeiou')
  end
end

p remove_vowel(['green', 'yellow', 'black', 'white'])
