# When you run the following code...

def equal_to_four(x)
  if x == 4
    puts "yup"
  else
    puts "nope"
end

equal_to_four(5)

# You get the following error message...

# test_code.rb:96: syntax error, unexpected end-of-input, expecting keyword_end

# ANSWER
# The reserved word "end" is missing from the equal_to_four method statement.
# The "end" in the code works for the if/else statement, leaving the method
# open. The interpreter was expecting an "end" for the method.
