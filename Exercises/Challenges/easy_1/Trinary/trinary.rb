class Trinary
  def initialize(trinary = '0')
    @trinary = valid_octal?(trinary) ? trinary : '0'
    @trinary_digits = @trinary.chars.map(&:to_i)
  end

  def to_decimal
    @trinary_digits.reverse_each.with_index.reduce(0) do |sum, (base_3, idx)|
      sum + base_3 * 3 ** idx
    end
  end

  def valid_octal?(trinary)
    /[0-2]+$/ =~ trinary
    # /[0-2]*/.match(trinary)[0] == trinary
  end
end
