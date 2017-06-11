# Input:
# - Integer >= 0 or String representing binary
# - Invalid string => binary value of 0
# - Valid Integers are 0-31
# - Valid binaries are 0 to 11111
# Output:
# - Invalid entry should be interpreted as 0
# - array of secret handshake operations
# - order of array starts with lowest powers of 2
# - reverse order if necessary

# Test cases:
# - test suite provided

# Algorithm:
# if input.is_a? Integer then check if (0..31).include? input
# if so, keep input and input = input.to_s(2)
#   elsif return empty array
# if input.is_a? String
#   if (0..31).include? input.to_i(2)
#     keep input
#   elsif return empty array
# input.split()
# input.reverse.each_with_index.map
#   transform to correct secret move
# return array
# if

# 1 = wink
# 10 = double blink
# 100 = close your eyes
# 1000 = jump


# 10000 = Reverse the order of the operations in the secret handshake.

# handshake = SecretHandshake.new 9
# handshake.commands # => ["wink","jump"]

# handshake = SecretHandshake.new "11001"
# handshake.commands # => ["jump","wink"]

class SecretHandshake
  COMMANDS = { 0 => 'wink', 1 => 'double blink', 2 => 'close your eyes', 3 => 'jump' }

  def initialize(input)
    @input = (input.is_a? String) ? input.to_i(2) : input
    @input = 0 unless (0..31).include? @input
  end

  def commands
    inputs = @input.to_s(2).split('')

    result = []
    inputs.reverse.each_with_index do |input, idx|
      break result.reverse! if idx == 4
      result << COMMANDS[idx] if input == '1'
    end

    result
  end
end
