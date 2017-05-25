# Group 1
# def check_return_with_proc
#   my_proc = proc { return }
#   my_proc.call
#   puts "This will never output to screen."
# end

# check_return_with_proc

# Group 2
# my_proc = proc { return }

# def check_return_with_proc_2(my_proc)
#   my_proc.call
# end

# check_return_with_proc_2(my_proc)

# Group 3
# def check_return_with_lambda
#   my_lambda = lambda { return }
#   my_lambda.call
#   puts "This will be output to screen."
# end

# check_return_with_lambda

# Group 4
# my_lambda = lambda { return }
# def check_return_with_lambda(my_lambda)
#   my_lambda.call
#   puts "This will be output to screen."
# end

# check_return_with_lambda(my_lambda)

# Group 5
def block_method_3
  yield
end

block_method_3 { return }

# ANSWER
## Group 1
# If a proc contains `return` then it will return from the method it is called by. Any code following it will not execute.

## Group 2
# I'm not sure what's happening here... A proc passed into a method is not the same as one defined inside a method.

## Group 3
# A lambda return will not return from the method it was called by. Later code in that method with still run.

## Group 4
# Even if a lambda is defined outside a method, it may be used inside the method is passed in as if it were defined inside the method.

## Group 5
