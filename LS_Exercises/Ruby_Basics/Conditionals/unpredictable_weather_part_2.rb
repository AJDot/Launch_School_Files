# Unpredictable Weather (Part 2)
#
# In the code below, sun is randomly assigned as 'visible' or 'hidden'.
#
# sun = ['visible', 'hidden'].sample
# Write an unless statement that prints "The clouds are blocking the sun!"
# unless sun equals 'visible'.

# ANSWER
sun = ['visible', 'hidden'].sample
unless sun == 'visible'
  puts "The clouds are blocking the sun!"
end
