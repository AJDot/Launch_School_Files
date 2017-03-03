# Quote Confusion
#
# Modify the following code so that double-quotes are used instead of
# single-quotes.
#
# puts 'It\'s now 12 o\'clock.'
# Expected output:
#
# It's now 12 o'clock.

# ANSWER
puts "It's now 12 o'clock."

puts %Q(This thing has "double" and 'single' quotes.)
puts %q(This thing has "double" and 'single' quotes.)
