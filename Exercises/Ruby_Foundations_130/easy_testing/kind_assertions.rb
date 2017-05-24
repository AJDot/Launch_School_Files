require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class Test < Minitest::Test
  def test_kind
    value = 1
    assert_kind_of Numeric, value
    assert_kind_of Numeric, Numeric.new
  end
end