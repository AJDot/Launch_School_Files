# after_midnight_part_2.rb

#Understand the problem
# Write two methods that each take a time of day in 24 hours format and return
# the number of minutes before and after midnight, respectively.
# Methods should return a value in the range 0..1439. Don't use Date and Time
# classes.
#  - Input: string in 24-hour time format
#  - Output:
#  - Return: integer representing minutes before/after midnight
#
#Examples / Test Cases
#  after_midnight('00:00') == 0
#  before_midnight('00:00') == 0
#  after_midnight('12:34') == 754
#  before_midnight('12:34') == 686
#  after_midnight('24:00') == 0
#  before_midnight('24:00') == 0

#
#Data Structures
#  - Input: (time) string in 24-hour time format
#  - Intermediate:
#  - Output:
#  - Return: (mins_from_midnight) integer
#
#Algorithm / Abstraction
#  - hours, min = time.split
#  - total_mins = hours * MINUTES_PER_HOUR + min
#  - For after_midnight
#    - mins_from_midnight = total_minutes
#  - For before_midnight
#    - mins_from_midnight = MINUTES_PER_DAY - total_minutes


# Program
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR
def after_midnight(time)
  hours, min = time.split(":").map(&:to_i)
  total_mins = hours * MINUTES_PER_HOUR + min
  mins_from_midnight = total_mins % MINUTES_PER_DAY
end
def before_midnight(time)
  mins_from_midnight = (MINUTES_PER_DAY - after_midnight(time)) % MINUTES_PER_DAY
end

puts after_midnight('00:00') == 0
puts before_midnight('00:00') == 0
puts after_midnight('12:34') == 754
puts before_midnight('12:34') == 686
puts after_midnight('24:00') == 0
puts before_midnight('24:00') == 0

puts "-------------------"
puts "Further Exploration"
puts "-------------------"
# If we could use the Date and Time classes...
def after_midnight_further(time)
  hours, min = time.split(":").map(&:to_i)
  new_time = Time.new(0, 1, 1, hours, min)
  new_time.hour * 60 + new_time.min
end
def before_midnight_further(time)
  delta_s = Time.at(MINUTES_PER_DAY * 60) - Time.at(after_midnight(time) * 60)
  (delta_s / 60) % MINUTES_PER_DAY

  # mins_from_midnight = delta_time.hour * MINUTES_PER_HOUR + delta_time.min
end
puts after_midnight_further('00:00') == 0
puts before_midnight_further('00:00') == 0
puts after_midnight_further('12:34') == 754
puts before_midnight_further('12:34') == 686
puts after_midnight_further('24:00') == 0
puts before_midnight_further('24:00') == 0
