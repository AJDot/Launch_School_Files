# For `assert_equal`, what exactly is tested for equality?

`assert_equal` uses the `==` method. This means that it is testing for _value equality_ and not _object equality_. To compare if two variables point to the same object, use `assert_same`.
A simple example to demonstrate this.
```ruby

assert_equal str1, str2                     # => Will evaluate to true
assert_equal str1.object_id, str2.object_id # => Will evaluate to false

str4 = str3
assert_equal str3, str4                     # => Will evaluate to true
assert_same str3, str4                      # => Will evaluate to true
```