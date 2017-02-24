# Given the array...

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
# Write a program that prints out groups of words that are anagrams. Anagrams
# are words that have the same exact letters in them but in a different order.
# Your output should look something like this:

# ["demo", "dome", "mode"]
# ["neon", "none"]
# (etc)

# ANSWER

ans = {}
words.each do |word|
  key = word.split('').sort.join # rearrange the letters, smallest to largest
  if ans.has_key?(key)
    ans[key].push(word) # if key does exist, add the word to the array
  else
    ans[key] = [word] # if the key doesn't exist create it and start the array
  end
end

ans.each do |k, v|
  p v
end
