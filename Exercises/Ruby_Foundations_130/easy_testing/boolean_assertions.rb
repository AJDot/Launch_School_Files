require 'minitest/autorun'

class Test < MiniTest::Test
  def test_odd_question
    value = 3
    assert value.odd?, 'value is not odd'
    value = 2
    assert value.odd?, 'value is not odd'
  end
end