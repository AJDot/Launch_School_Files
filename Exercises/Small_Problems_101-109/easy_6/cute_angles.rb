# cute_angles.rb

#Understand the problem
# Write a method that takes a floating point number that represents an angle
# between 0 and 360 degrees and returns a String that represents that angle
# in degrees, minutes, and seconds. You should ue the degree symbol to
# represent degrees, a single quote for minutes, and a double quote for
# seconds.
#  - Input: floating point number
#  - Output:
#  - Return: number converted to degrees, mins, secs
#
#Examples / Test Cases
#  dms(30) == %(30°00'00")
#  dms(76.73) == %(76°43'48")
#  dms(254.6) == %(254°36'00")
#  dms(93.034773) == %(93°02'05")
#  dms(0) == %(0°00'00")
#  dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
#
#Data Structures
#  - Input: (number) = floating point
#  - Intermediate:
#  - Output:
#  - Return: formatted string
#
#Algorithm / Abstraction
#  - degree, remainder = number.divmod(1)
#  - min = remainder * 60
#  - sec = min % 1 * 60

# Program
DEG_SYMBOL = "\xc2\xb0"
MIN_PER_DEG = 60
SEC_PER_MIN = 60
SEC_PER_DEG = MIN_PER_DEG * SEC_PER_MIN

def dms(angle)
  total_seconds = (angle * SEC_PER_DEG).round
  degrees, remaining_secs = total_seconds.divmod(SEC_PER_DEG)
  min, sec = remaining_secs.divmod(SEC_PER_MIN)
  format(%(#{degrees}#{DEG_SYMBOL}%02d'%02d"), min, sec)
end
puts dms(30) == %(30°00'00")
puts dms(76.73) == %(76°43'48")
puts dms(254.6) == %(254°36'00")
puts dms(93.034773) == %(93°02'05")
puts dms(0) == %(0°00'00")
puts dms(360) == %(360°00'00") || dms(360) == %(0°00'00")

puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
# While our solution works with the expanded range of non-negative numbers, it
# fails with negative numbers. For instance, dms(-76.73) returns -77°16'12",
# which is incorrect. Modify our solution so it works with negative values as
# well as non-negative values.
def dms_further(angle)
  negative = angle < 0
  angle = angle.abs
  total_seconds = (angle * SEC_PER_DEG).round
  degrees, remaining_secs = total_seconds.divmod(SEC_PER_DEG)
  min, sec = remaining_secs.divmod(SEC_PER_MIN)
  degrees = -degrees if negative
  format(%(#{degrees}#{DEG_SYMBOL}%02d'%02d"), min, sec)
end
puts dms_further(-30) == %(-30°00'00")
puts dms_further(-76.73) == %(-76°43'48")
puts dms_further(-254.6) == %(-254°36'00")
puts dms_further(-93.034773) == %(-93°02'05")
puts dms_further(-0) == %(0°00'00")
puts dms_further(-360) == %(-360°00'00") || dms(360) == %(0°00'00")
