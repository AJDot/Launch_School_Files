def fizzbuzz(start, stop)
  result = []
  start.upto(stop) do |n|
    result << if n % 3 == 0 && n % 5 == 0
                'fizzbuzz'
              elsif n % 3 == 0
                'fizz'
              elsif n % 5 == 0
                'buzz'
              else
                n
              end
  end
  result
end

p fizzbuzz(1, 15)
