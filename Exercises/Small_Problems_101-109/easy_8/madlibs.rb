# madlibs.rb

#Understand the problem
#  Mad libs are a simple game where you create a story template with blanks for
#  words. You, or another player, then construct a list of words and place
#  them into the story, creating an often silly or funny story as a result.
#  Create a simple mad-lib program that prompts for a noun, a verb, an adverb,
#  and an adjective and injects those into a story that you create.
#  - Input: set of strings from user
#  - Output:
#  - Return: string with inputs injected into it
#
#Examples / Test Cases
#  Enter a noun: dog
#  Enter a verb: walk
#  Enter an adjective: blue
#  Enter an adverb: quickly
#
#  Do you walk your blue dog quickly? That's hilarious!

#Data Structures
#  - Input: (noun, verb, adjective, adverb)
#  - Intermediate:
#  - Output:
#  - Return: sentence with all these pieces in it
#
#Algorithm / Abstraction
#  - get noun, verb, adjective, adverb
#  - insert these into a template

# Program
puts "\n-------"
puts "Program"
puts "-------"
print 'Enter a noun: '
noun = gets.chomp
print 'Enter a verb: '
verb = gets.chomp
print 'Enter an adjective: '
adjective = gets.chomp
print 'Enter an adverb: '
adverb = gets.chomp

puts "You have a #{adjective} #{noun} that knows how to #{verb} #{adverb}!? ..."

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
