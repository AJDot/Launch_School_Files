=begin
  Better program logger.
  The output from the last logger was kind of hard to read. It would be nice
  if the log indented the lines in teh inner blocks. So, you'll need to keep
  track of how deeply nested you are every time the logger wants to write
  something. to do this, use a global variable, which is a variable you can
  see from anywhere in your code. To make a global variable, just preced your
  variable name with $, like so: $global and $nesting_depth. In the end,
  your logger should output code like this.
=end

$nesting_depth = -1
def log description, &block
  $nesting_depth += 1
  indent = '  ' * $nesting_depth
  puts "#{indent}Beginning \"#{description}\"..."
  result = block.call
  puts "#{indent}...\"#{description}\" finished, returning: #{result.to_s}"
  $nesting_depth -= 1
end

log("outer block") do
  log("some little block") do
    number = 1
    5.times do
      number += number
    end
    log("some tiny block") do
      "tiny block"
    end
    number
  end
  log("yet another block") do
    "This is the last block"
  end
  "awesome"
end
