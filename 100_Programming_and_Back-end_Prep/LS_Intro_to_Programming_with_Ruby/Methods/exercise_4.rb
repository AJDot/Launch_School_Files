# What would the following code print to the screen?

def scream(words)
  words = words + "!!!!"
  return
  puts words
end

scream("Yippeee")

# This would output nothing. "puts words" will never be executed.
