# now_i_know_my_abcs.rb

#Understand the problem
#  A collection of spelling blocks has two letters per block, as shown in this
#  list.
#  B:O  X:K  D:Q  C:P  N:A
#  G:T  R:E  F:S  J:W  H:U
#  V:I  L:Y  Z:M

# This limits the words you can spell with the blocks to just those words that
# do not use both letters from any given block. Each block can only be used
# once.

#  Write a method that returns true if the word passed in as an argument can be
#  spelled from this set of blocks, false otherwise.

#Examples / Test Cases
#  block_word?('BATCH') == true
#  block_word?('BUTCH') == false
#  block_word?('jest') == true

#Data Structures
#  - Input: (string) = the word to test
#  - Intermediate: array of arrays for each block
#  - Output:
#  - Return: (boolean) = if the word can be formed from the blocks
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def block_word?(word)
  blocks = [
    ['B', 'O'], ['X', 'K'], ['D', 'Q'], ['C', 'P'],
    ['N', 'A'], ['G', 'T'], ['R', 'E'], ['F', 'S'],
    ['J', 'W'], ['H', 'U'], ['V', 'I'], ['L', 'Y'],
    ['Z', 'M']
  ]
  blocks_used = []
  letters = word.upcase.chars
  letters.each do |letter|
    blocks.each do |block|
      if block.include?(letter) #&& !blocks_used.include?(block)
        blocks_used << blocks.delete(block)
        break
      end
    end
  end
  blocks_used.size == letters.size
end

puts block_word?('BATCH') == true
puts block_word?('BUTCH') == false
puts block_word?('jest') == true

puts "\n-----------"
puts "LS Solution"
puts "-----------"
BLOCKS = %w(BO XK DQ CP NA GT RE FS JW HU VI LY ZM).freeze

def block_word?(string)
  up_string = string.upcase
  BLOCKS.none? { |block| up_string.count(block) >= 2 }
end

puts block_word?('BATCH') == true
puts block_word?('BUTCH') == false
puts block_word?('jest') == true

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"

