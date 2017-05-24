require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class Test < Minitest::Test
  def test_kind
    value = 1
    assert_same value, value
    assert_same Numeric.new, Numeric.new
  end
end