# Write a method that takes one argument, a positive integer, and
# returns a string of alternating 1s and 0s, always starting with 1.
# The length of the string should match the given integer.

def stringy(number)
  result = ''
  number.times do |idx|
    result << (idx.even? ? '1' : '0')
  end
  result
end

p stringy(6) == "101010"
p stringy(9) == "101010101"
p stringy(4) == "1010"
p stringy(7) == "1010101"
p stringy(14)

def stringy(integer)
  string = ''
  until string.length >= integer
    string << ('1')
    if string.length == integer
      break
    end
    string << ('0')
  end
  string
end

def stringy(n)
	result = "0" * n
	result.chars.each_with_index { |l, idx| result[idx] = '1' if idx.even? }
	result
end

def stringy(number)
  result = ''
  number.times do |idx|
    result << (idx.even? ? '1' : '0')
  end
  result
end

def stringy(size)
  (1..size).map do |num|
    num.odd? ? "1" : "0"
  end.join
end

def stringy(n)
  return '1' if n == 1
	n.even? ? "10" * (n / 2) : ("10" * (n / 2)) +"1"
end
