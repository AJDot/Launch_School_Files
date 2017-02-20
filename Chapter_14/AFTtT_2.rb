=begin
  Grandfather clock.
  Write a method that takes a block and calls it once for each hour that has
  passed today. That way, if I were to apss in the block:
    do
      puts 'DONG!'
    end
  it would chime (sort of) like a grandfather clock. Test your method out
  with a few different blocks.

  Hint: You can use Time.new.hour to get the current hour. However, this
  returns a number between 0 and 23, so you will have to alter those numbers
  in order to get ordinary clock-face numbers (1 to 12).
=end

def chime &block
  hour = Time.new.hour
  if hour != 12
    hour = (hour % 12) # convert to 12-hour time format
  end

  hour.times do        # could write as hour.times(&block)
    block.call         
  end
  puts "I did a thing #{hour} times!"
end

chime do
  puts 'DONG!'
end
