require 'minitest/autorun'
require_relative 'gcf'

class GCFTest < Minitest::Test
  def test_small_numbers
    assert_equal(4, GCF.new(8, 12).calculate)
  end

  def test_small_numbers_2
    assert_equal(6, GCF.new(12, 18).calculate)
  end

  def test_result_is_an_input
    assert_equal(15, GCF.new(15, 105).calculate)
  end

  def test_large_numbers
    assert_equal(3, GCF.new(12345, 54321).calculate)
  end

  def test_large_numbers_2
    assert_equal(3, GCF.new(123456, 654321).calculate)
  end

  def test_factor_is_1
    assert_equal(1, GCF.new(11, 100).calculate)
  end

  def test_same_number
    assert_equal(76895, GCF.new(76895, 76895).calculate)
  end
end