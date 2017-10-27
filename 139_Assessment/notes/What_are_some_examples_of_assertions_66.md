# What are some examples of assertions?

Assertions are the actual verification that your code is doing what you expect.

Here are some extremely contrived examples for core Ruby methods and one other:
```ruby

class CustomClass
  attr_reader :name
end

class CoreRubyTest < Minitest::Test
  def test_sort_method_for_integers
    assert_equal [1, 2, 3, 4, 5], [4, 5, 3, 2, 1].sort
  end

  def test_select_method_for_integers
    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    assert_equal [1, 2, 3, 4, 5], array.select { |num| num < 6 }
    assert_equal [2, 4, 6, 8, 10], array.select { |num| num.even? }
  end

  def test_error_thrown_for_invalid_method
  end

  def test_nil_on_something
    assert_nil CustomClass.new.name
  end
end
```