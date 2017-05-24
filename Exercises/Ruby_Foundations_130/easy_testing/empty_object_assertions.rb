require 'minitest/autorun'

class Test < Minitest::Test
  def test_empty
    list = []
    assert_equal true, list.empty?
    list = [1, 2, 3]
    assert_equal true, list.empty?
    list = []
    assert_empty list
  end
end