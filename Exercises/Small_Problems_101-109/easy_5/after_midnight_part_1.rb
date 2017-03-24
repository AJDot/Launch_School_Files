# after_midnight_part_1.rb

#Understand the problem
# Time of day can be represented as the number of minutes before or after
# midnight. If the number is positive => after midnight. If number is negative
# => before midnight.
# Write a method that takes a time using this minute-based format and returns
# the time of day in 24 hour format (hh:mm). Your method should work with any
# integer input.
#  - Input: number of minutes before or after midnight
#  - Output:
#  - Return: the corresponding time in 24-hour hh:mm format
#
#Examples / Test Cases
#  time_of_day(0) == "00:00"
#  time_of_day(-3) == "23:57"
#  time_of_day(35) == "00:35"
#  time_of_day(-1437) == "00:03"
#  time_of_day(3000) == "02:00"
#  time_of_day(800) == "13:20"
#  time_of_day(-4231) == "01:29"

#
#Data Structures
#  - Input: integer (number)
#  - Intermediate:
#  - Output:
#  - Return: interpolated string with mins and hours in hh:mm format
#
#Algorithm / Abstraction
#  - total_minutes = method input
#  - MINUTES_PER_DAY = 24*60
#  - time = total_minutes % MINUTES_PER_DAY
#  - hours, mins = time.divmod(60)
#  - return "#{format('%2.i', hours)}:#{format('%2.i', mins)}"

# Program
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR
def time_of_day(total_minutes)
  time = total_minutes % MINUTES_PER_DAY
  hours, mins = time.divmod(MINUTES_PER_HOUR)
  format('%02d:%02d', hours, mins)
end

puts time_of_day(0) == "00:00"
puts time_of_day(-3) == "23:57"
puts time_of_day(35) == "00:35"
puts time_of_day(-1437) == "00:03"
puts time_of_day(3000) == "02:00"
puts time_of_day(800) == "13:20"
puts time_of_day(-4231) == "01:29"

puts "-------------------"
puts "Further Exploration"
puts "-------------------"
# Include the day of the week, starting from midnight between Saturday and
# Sunday
DAYS = {0 => 'Sunday', 1 => 'Monday', 2 => 'Tuesday',
        3 => 'Wednesday', 4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday'}
DAYS_IN_WEEK = 7
def time_of_day_further(total_minutes)
  day_key = (total_minutes / MINUTES_PER_DAY) % DAYS_IN_WEEK
  "#{DAYS[day_key]} #{time_of_day(total_minutes)}"
end

puts time_of_day_further(-4231) == "Thursday 01:29"
puts time_of_day_further(8 * MINUTES_PER_DAY +
                         6 * MINUTES_PER_HOUR +
                          29) == "Monday 06:29"
puts time_of_day_further(7 * MINUTES_PER_DAY +
                         1 * MINUTES_PER_HOUR +
                         29) == "Sunday 01:29"

# Solve this using the Date and Time classes.
puts "-----------------------"
puts "Using Date/Time Classes"
puts "-----------------------"
def time_using_time_class(total_minutes)
  new_time = Time.new(2017, 1, 1) + total_minutes * 60
  new_time.strftime("%A %H:%M")
end

puts time_using_time_class(-4231) == "Thursday 01:29"
puts time_using_time_class(8 * MINUTES_PER_DAY +
                         6 * MINUTES_PER_HOUR +
                          29) == "Monday 06:29"
puts time_using_time_class(7 * MINUTES_PER_DAY +
                         1 * MINUTES_PER_HOUR +
                         29) == "Sunday 01:29"
