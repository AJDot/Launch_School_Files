require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

class Test < Minitest::Test
  def test_type
    value = 1
    assert_instance_of Numeric, value
    assert_instance_of Numeric, Numeric.new
  end
end