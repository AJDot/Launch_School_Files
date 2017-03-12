# mortgage_calculator.rb

# Take the loan amount, annual percentage rate (APR), and the loan duration
# then calculate the monthly interest rate and loan duration in months

# Use m = p * (j / (1 - (1 + j)**(-n))) where:
# m = monthly payment
# p = loan amount
# j = monthly interest rate
# n = loan duration in months

# Pseudo code

# START
#
# Using the variable names above
#
# GET p = loan amount
# GET apr = annual percentage rate in %
# GET d = loan duration in years
#
# SET n = d * 12 (loan duration in months)
#
# SET apr_dec = apr / 100 (convert apr to decimal for calculation)
# SET j = apr_dec / 12 (monthly interest rate)
#
# SET m = p * (j / (1 - (1 + j)**(-n))) (monthly payment)
#
# PRINT m
#
# END

def prompt(message)
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

puts
prompt("-------------------------------")
prompt("Welcome to Mortgage Calculator!")
prompt("-------------------------------")
puts

# main loop
loop do
  amt = ''
  loop do
    prompt("What is the loan amount? (in $)")
    amt = gets.chomp

    if number?(amt) && amt.to_f > 0
      break
    else
      prompt("Invalid. Please enter a positive number.")
    end
  end

  apr = ''
  loop do
    prompt("What is the annual percentage rate? (in %)")
    apr = gets.chomp

    if number?(apr) && apr.to_f > 0
      break
    else
      prompt("That is not a valid number.")
    end
  end

  dur_year = ''
  loop do
    prompt("What is the duration of the loan? (in years)")
    dur_year = gets.chomp

    if integer?(dur_year) && dur_year.to_i > 0
      break
    else
      prompt("That is not a valid number. Please enter a whole number value.")
    end
  end

  dur_month = dur_year.to_i * 12  # loan duration in months

  apr_dec = apr.to_f / 100        # convert apr to decimal

  rate_month = apr_dec / 12       # monthly interest rate

  monthly_payment = amt.to_i *
                    (rate_month /
                    (1 - (1 + rate_month)**-dur_month)) # monthly payment

  prompt("Your monthly payment is $#{format('%02.2f', monthly_payment)}
          for #{dur_month} months.")
  prompt("Would you like to calculate another loan? (Y for yes)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for using the Mortgage Calculator! Good bye!")
