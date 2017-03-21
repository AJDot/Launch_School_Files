# greeting_a_user.rb

#Understand the problem
#  - ask for user's name then greet the user. If the user writes "name!" then
#  - the computer yells back to the user.
#  - Input: name of user
#  - Output: greeting to user
#
#Examples / Test Cases
#  - What is your name? Bob
#  - Hello Bob.
#
#  - What is your name? Bob!
#  - HELLO BOB. WHY ARE WE SCREAMING?
#
#Data Structures
#  - Input: (string) user name
#  - Output: (string) greeting
#
#Algorithm / Abstraction
#  - get user name
#  - if user yells (!) then display yelling greeting
#  - otherwise display normal greeting

# Program
print 'What is your name? '
name = gets
name.chomp!

if name.end_with?('!')
  name.chop!
  puts "HELLO #{name.upcase}. WHY ARE WE SCREAMING?"
else
  puts "Hello #{name}."
end
