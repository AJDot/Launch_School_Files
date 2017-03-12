# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

require 'yaml'

MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = "es"

def messages(message, lang="en")
  MESSAGES[lang][message]
end

def prompt(key)
  message = if messages(key, LANGUAGE)
              messages(key, LANGUAGE)
            else
              key
            end

  Kernel.puts("=> #{message}")
end

def integer?(num)
  num == num.to_i.to_s
end

def float?(num)
  num == num.to_f.to_s
end

def number?(num)
  integer?(num) || float?(num)
end

prompt("welcome")

name = ''
loop do
  name = Kernel.gets.chomp

  if name.empty?
    prompt("valid_name")
  else
    break
  end
end

def operation_to_message(op)
  message = case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            when '4'
              'Dividing'
            end
  message
end

prompt("Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt("What's the first number?")
    number1 = Kernel.gets.chomp

    if number?(number1)
      break
    else
      prompt("valid_number")
    end
  end

  number2 = ''
  loop do
    prompt("What's the second number?")
    number2 = Kernel.gets.chomp

    if number?(number2)
      break
    else
      prompt("valid_number")
    end
  end

  prompt("operator_prompt")

  operator = ''
  loop do
    operator = Kernel.gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("valid_operator")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result =  case operator
            when '1'
              number1.to_i + number2.to_i
            when '2'
              number1.to_i - number2.to_i
            when '3'
              number1.to_i * number2.to_i
            when '4'
              number1.to_f / number2.to_f
            end

  prompt("The result is #{result}")

  prompt("another_calculation?")
  answer = Kernel.gets.chomp
  break unless answer.downcase().start_with?('y')
end

prompt("exit")
