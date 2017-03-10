# You run the following code...
# names = ['bob', 'joe', 'susan', 'margaret']
# names['margaret'] = 'jody'

# ...and get the following error message:
# TypeError: no implicit conversion of String into Integer
#   from (irb):2:in `[]='
#   from (irb):2
#   from /Users/username/.rvm/rubies/ruby-2.0.0-p353/bin/irb:12:in `<main>'

# What is the problem and how can it be fixed?

# ANSWER
# User is trying to access an array element using the value of the element
# instead of the index of that element in the array.
# Solution: names[3] = 'jody'
