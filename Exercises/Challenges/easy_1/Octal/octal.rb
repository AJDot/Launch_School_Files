class Octal
  def initialize(octal = '0')
    @octal = valid_octal?(octal) ? octal : '0'
    @octal_digits = @octal.chars.map(&:to_i)
  end

  def to_decimal
    @octal_digits.reverse_each.with_index.reduce(0) do |sum, (base_8, idx)|
      sum + base_8 * 8 ** idx
    end
  end

  def valid_octal?(octal)
    /[0-7]+$/ =~ octal
    # /[0-7]*/.match(octal)[0] == octal
  end
end
