# Write a method to determine if a word is a palindrome, without using the reverse method

def palindrome?(string)
  mid = string.size / 2
  downcased = string.downcase
  stripped = downcased.gsub(/[^a-z]/, '')
  mid.times do |idx|
    return false if stripped[idx] != stripped[-(idx + 1)]
  end
  true
end

p palindrome?('aaabbaaa')
p palindrome?('Able was I ere I saw Elba')
p palindrome?('A man, a plan, a canal - Panama!')
p palindrome?("Mr. Owl ate my metal worm")
p palindrome?("Was it a cat I saw?")
p palindrome?('A man, a plan, a canal - Panama!')
p palindrome?('A man, a plan, a canal - Panama!')
