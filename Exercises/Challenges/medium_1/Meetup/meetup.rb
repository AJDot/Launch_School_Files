require 'date'

class Meetup
  FIRST_DAY = {
    :first => 1,
    :second => 8,
    :third => 15,
    :fourth => 22,
    :last => -7,
    :teenth => 13
  }

  def initialize(month, year)
    @date = Date.new(year, month)
  end

  def day(weekday, schedule)
    result = Date.new(@date.year, @date.month, FIRST_DAY[schedule])
    result += 1 until result.public_send(weekday.to_s + '?')
    result
  end
end
