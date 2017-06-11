class Clock
  MIN_IN_DAY = 60 * 24

  def self.at(hour = 0, min = 0)
    new(hour, min)
  end

  def initialize(hour, min)
    @total_mins = hour * 60 + min
    reform
  end

  def +(minutes)
    @total_mins += minutes
    reform
    self
  end

  def -(minutes)
    self.+(-minutes)
  end

  def to_s
    "%02d:%02d" % [@hours, @mins]
  end

  def ==(other)
    to_s == other.to_s
  end

  private

  def reform
    @total_mins %= MIN_IN_DAY
    @hours, @mins = @total_mins.divmod(60)
  end
end
