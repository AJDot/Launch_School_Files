require 'minitest/autorun'

class Test < Minitest::Test
  def test_downcase_xyz
    value = 'XYZ'
    assert_equal('xyz', value.downcase)
    value = 'ABC'
    assert_equal('xyz', value.downcase)
  end
end