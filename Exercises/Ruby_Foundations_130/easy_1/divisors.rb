def divisors(dividend)
  1.upto(dividend / 2).select do |divisor|
    dividend % divisor == 0
  end + [dividend]
end

puts divisors(1) == [1]
puts divisors(7) == [1, 7]
puts divisors(12) == [1, 2, 3, 4, 6, 12]
puts divisors(98) == [1, 2, 7, 14, 49, 98]
puts divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute

# Further Exploration
def divisors_further(dividend)
  result = []
  1.upto(Math.sqrt dividend).each do |divisor|
    quotient, remainder = dividend.divmod(divisor)
    result += [divisor, quotient] if remainder == 0
  end
  result.sort.uniq
end

p divisors_further(1) == [1]
p divisors_further(7) == [1, 7]
p divisors_further(12) == [1, 2, 3, 4, 6, 12]
p divisors_further(98) == [1, 2, 7, 14, 49, 98]
p divisors_further(99400891) == [1, 9967, 9973, 99400891] # may take a minute
start = Time.now
p divisors_further(999962000357) == [1, 999979, 999983, 999962000357]
stop = Time.now
p stop - start
start = Time.now
p divisors_further(9007199254740881) == [1, 9007199254740881]
stop = Time.now
p stop - start
