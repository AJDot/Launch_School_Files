class School
  def initialize
    @roster = Hash.new { |h, k| h[k] = [] }
  end

  def add(name, grade)
    @roster[grade] << name
  end

  def grade(num)
    @roster[num].sort
  end

  def to_h
    result = {}
    @roster.keys.sort.each do |_grade|
      result[_grade] = grade(_grade)
    end
    result
  end
end
