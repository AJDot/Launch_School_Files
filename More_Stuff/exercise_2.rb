# What will the following program print to the screen? What will it return?

def execute(&block)
  block
end

execute { puts "Hello from inside the execute method!" }

# ANSWER
# Will print nothing because the block was not called
# Will return a Proc object
