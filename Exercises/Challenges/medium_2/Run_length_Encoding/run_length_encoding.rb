# input:
#   - string to encoding:
#     - string of letters and spaces and unicode
#     - no numbers
#   - encoding to string:
#     - numbers separated by single characters or space

# output:
#   - string to encoding:
#     - repeated characters shorten to the number of characters followed by the character
#   - encoding to string:
#     - expanded string where each character is repeated n time where n is the number in front of that character.

# algorithm:
#   - decode:
#     - step through string and split when character changes
#     - need to maintain order, so array structure like
#     - [['W', 13], ['B', 11], ['W', 10]...]
#     - map to string and return
#   - encode:
#     - detect each number and character pair
#     - map to expand

class RunLengthEncoding
  def self.decode(input)
    splits = input.split(/(\D)/)

    result = ''
    splits.each_slice(2) do |count, char|
      num = count == '' ? 1 : count.to_i
      result << char * num
    end
    result
  end

  def self.encode(input)
    result = ''
    current_char = input[0]
    count = 0

    input.each_char do |char|
      last_char = current_char
      current_char = char

      next count += 1 if current_char == last_char

      result << next_info(last_char, count)
      count = 1
    end

    result << next_info(input[-1], count)
    result
  end

  # using only regex (second solution after viewing others)
  # def self.encode(input)
  #   input.gsub(/(.)\1+/) { |match| match.size.to_s + match[0] }
  # end

  private

  def self.next_info(char, count)
    (count == 1 ? '' : count.to_s) + char
  end
end
