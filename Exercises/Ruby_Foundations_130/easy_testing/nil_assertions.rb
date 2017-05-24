require 'minitest/autorun'

class Test < Minitest::Test
  def test_nil
    value = nil
    assert_nil value
    value = 'ABC'
    assert_nil value
  end
end