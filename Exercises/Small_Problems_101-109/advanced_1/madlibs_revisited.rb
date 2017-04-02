# madlibs_revisited.rb

#Understand the problem
# Let's build another program using madlibs. We made a program like this in the
# easy exercises. This time, the requirements are a bit different.

# Make a madlibs program that reads in some text from a text file that you
# have
# created, and then plugs in a selection of randomized nouns, verbs,
# adjectives,
# and adverbs into that text and prints it. You can build your lists of nouns,
# verbs, adjectives, and adverbs directly into your program, but the text data
# should come from a file or other external source. Your program should read
# this
# text, and for each line, it should place random words of the appropriate
# types
# into the text, and print the result.

#Examples / Test Cases
# Example output
#  The sleepy brown cat noisily
#  licks the sleepy yellow
#  dog, who lazily licks his
#  tail and looks around.

#Data Structures
#  - Input:
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
NOUNS = %w(dog cat broom fish\ stick)
VERBS = %w(bites scratches sweeps squeaks)
ADJECTIVES = %w(furry lazy sleepy ugly)
ADVERBS = %w(stupidly lazily quickly slowly disparagingly)
DATABASE = {'NOUN' => NOUNS,
            'VERB' => VERBS,
            'ADJE' => ADJECTIVES,
            'ADVE' => ADVERBS}

def madlib(file_name)
  File.open(file_name) do |file|
    file.each do |line|
      modified_line = line
      modified_line =  modified_line.gsub(/\*{2}NOUN\*{2}/, NOUNS.sample)
      modified_line =  modified_line.gsub(/\*{2}VERB\*{2}/, VERBS.sample)
      modified_line =  modified_line.gsub(/\*{2}ADJE\*{2}/, ADJECTIVES.sample)
      modified_line =  modified_line.gsub(/\*{2}ADVE\*{2}/, ADVERBS.sample)
      puts modified_line
    end
  end
end

madlib('madlibs_text.txt')

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
