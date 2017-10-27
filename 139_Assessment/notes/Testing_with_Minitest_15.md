# Testing with Minitest
## Why Write Tests

## Testing Terminology
* __Test Suite__: it is the entire set of tests for your program
* __Test__: This is the situation in which to test a feature. For example, this test is used to ensure correct formatting on output. This test is used to ensure invalid inputs raise a error.
* __Assertion__: This is the actual verification step to confirm the result is as expected. You

## Minispec vs. RSpec
### RSpec
RSpec is a __Domain Specific Language__ (DSL) for writing tests. It is just Ruby code that is developed in a way to read easier but can be more complex to implement.

### Minitest
Minitest is used to write tests as well but in a more straight-forward way. It reads mostly like normal Ruby code without a lot of magical syntax.


## SEAT Approach
* Setup the necessary objects
  * Use the `setup` method to create the necessary objects that can be used in all tests.
* Assert the results of the execution.
* tear down and clean up any lingering artifacts
  * Used the `teardown` method to wrap up everything such as closing files.

## Assertions
Assertions are the actual verficiation that your code is running as expected. There are assertions of many different types. Here are a few:
* assert(test): Fails unless `test` is truthy.
* assert_equal(exp, act): Fails unless `exp == act`.
* assert_nil(obj): Fails unless `obj` is `nil`.
* assert_raises(*exp) {...}: Fails unless block raises one of `*exp`.
* assert_instance_of(cls, obj): Fails unless `obj` is an instance of `cls`.
* assert_includes(collection, obj): Fails unless `collection` includes `obj`.

### `assert_equal`
`assert_equal` tests for _value equality_. This is invoking the `==` method on the object. Two strings with the same text will pass the test. Use `assert_same` to utilize object equality `===`. This will only pass if both variables reference the same object.
To use this with a custom class, just make sure a `==` method is implemented.