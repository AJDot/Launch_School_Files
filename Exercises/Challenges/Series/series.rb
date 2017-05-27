class Series
  def initialize(digits = '')
    @digits = digits
  end

  def slices(series_size)
    unless (1..@digits.size).include? series_size
      raise ArgumentError, 'Slice size is too large.'
    end

    stop = @digits.size - series_size

    0.upto(stop).map do |idx|
      @digits.slice(idx, series_size).chars.map(&:to_i)
    end
  end
end

# series = Series.new('01234')

# p series.slices(1)
# p series.slices(2)
# p series.slices(3)