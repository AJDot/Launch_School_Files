# Why does the following code...

def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }
# Give us the following error when we run it?

# block.rb1:in `execute': wrong number of arguments (0 for 1) (ArgumentError)
# from test.rb:5:in `<main>'

# ANSWER
# The '&' was left out of the method definition. In this way, 'block' is an
# an argument that needs to be passed to 'execute' instead of the intended
# block like the last line indicates.
