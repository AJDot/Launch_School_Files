require 'minitest/autorun'

class Test < Minitest::Test
  def test_includes
    list = []
    assert_includes list, 'xyz'
    list = [1, 2, 3]
    assert_includes list, 'xyz'
  end
end