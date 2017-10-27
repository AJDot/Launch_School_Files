# Lesson 2 - Introduction to Testing
## Introduction
This lesson will __NOT__ talk about:
* Test Driven Development
* Test Driven Design
* Behavioral Driven Development
* Acceptance Test Driven Development
* Rspec
* Testing with a web framework, like Rails
* Test-first vs test-after
* How testing helps influence design choices

This lesson will focus on the bare essentials. The Ruby testing library, Minitest, will be used.

### Why Write Tests

### Testing Jargon
* "Did the PR pass continous integration tests?"
* "I feel our functional tests are getting redundant given our integration tests."
* "What ATDD tool do you like?"
* "Does your team practice TDD?"
* "I write unit tests, but not controller tests."

Ignore them all for now. This will focus on just testing simple classes. If a name must be given to this, think of is as learning _unit testing_.

## Minitest
Many people use RSpec, but Minitest is the default testing library that comes with Ruby. The difference is that RSpec bends over backwards to allow developers to write code that reads like English. RSpec is a __Domain Specific Language__ for writing tests.

Minitest reads just like normal Ruby code. No DSL, just Ruby.

### Vocabulary
* __Test Suite:__ the entire set of tests that accompanies your program or application. _All the tests_ for a project.
* __Test:__ the context in which tests are run. This test is to ensure an error for a wrong password. A test may have many assertions.
* __Assertion:__ The actual verification step to confirm the data returned by your program is indeed what is expected.

### Your First Test
See (/130_Ruby_Foundations_More_Topics/lesson_2/car.rb) and (/130_Ruby_Foundations_More_Topics/lesson_2/car_test.rb)
```ruby


class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
  
  def test_bad_wheels
    car = Car.new
    assert_equal(3, car.wheels)
  end
end
```
* `class CarTest < MiniTest::Test` allows our car tests to use the Minitest
* create tests using methods that start with __test\\___.
* Make assertions inside each test.
  * setup the data or objects - the particular situation in which the program is in for the test.
  * `assert_equal` takes two parameters: the expected value and the test or actual value.
  * If there is a discrepancy, `assert_equal` will save the error and Minitest will report that error to you at the end of the test run.
* Multiple assertions can be in one test.

Output from above:
```
$ ruby car_test.rb

Run options: --seed 8732

# Running:

CarTest F.

Finished in 0.001222s, 1636.7965 runs/s, 1636.7965 assertions/s.

  1) Failure:
CarTest#test_bad_wheels [car_test.rb:13]:
Expected: 3
  Actual: 4

2 runs, 2 assertions, 1 failures, 0 errors, 0 skips
```
The "F" means one test failed. The "." means one test passed.

Include the following to have a formatted output.
```ruby
require "minitest/reporters"
Minitest::Reporters.use!
```

### Skipping Tests
Just include `skip` keyword at start of test.
```ruby
# ... rest of code
def test_bad_wheels
    skip
    car = Car.new
    assert_equal(3, car.wheels)
  end
```

### Expectation Syntax
So far we have been using _assertion_ or _assert-style_ syntax. The other style of syntax is _expectation_ or _spec-style_ syntax.

In this, tests are grouped into `describe` blocks, and individual tests are written with the `it` method. Assertions are no longer use - instead use _expectation matchers_. Example:
```ruby


    car = Car.new
    car.wheels.must_equal 4           # this is the expectation
  end
end
```

### Summary
* Minitest is an intuitive test library that comes with Ruby
* Create a test file by subclassing `MiniTest::Test`.
* Create a test by creating an instance method that starts with `text_`.
* Create assertions with `assert_equal`, and pass it the expected value and the actual value.
* Clorize Minitest output with `minitest-reporters`
* You can skip tests with `skip`.
* Minitest comes in two syntax flavors: assertion style and expectation style. the latter is the appease RSpec users, but the former is for more intuitive for beginning Ruby developers.

## Assertions
`assert_equal` is impressive and a lot can be accomplished with it alone but there are others. Here is a full list of them and below is a table of a select few. [Full Assertions List](http://docs.seattlerb.org/minitest/Minitest/Assertions.html).

| Assertion | Desciption |
| --- | --- |
| `assert(test)` | Fails unless test is truthy |
| `assertequal(exp, act)` | Fails unless `exp == act` |
| `assert_nil(obj)` | Fails unless `obj` is `nil`. |
| `assert_raises(*exp) { ... }` |	Fails unless block raises one of `*exp`. |
| `assert_instance_of(cls, obj)` | Fails unless `obj` is an instance of `cls`. |
| `assert_includes(collection, obj)` | Fails unless `collection` includes `obj`. |

#### Refutations
These are the opposite of assertions. They _refute_ rather than _assert_. There is a `refute_equal`, `refute_includes`, etc. These are rarely used.

#### Summary
Learn the most popular assertoins and you should be good.

## SEAT Approach

There are usually 4 steps to writing a test:
1. Set up the necessary objects.
3. Assert the results of the execution.
4. Tear down and clean up any lingering artifacts.

This is the SEAT approach. Take a look at our example.
```ruby


class CarTest < MiniTest::Test
  def test_car_exists
    car = Car.new
    assert(car)
  end

  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_name_is_nil
    car = Car.new
    assert_nil(car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")   # this code raises ArgumentERror, so this assertion passes
    end
  end

  def test_instance_of_car
    car = Car.new
    assert_instance_of(Car, car)
  end

  def test_includes_car
    car = Car.new
    arr = [1, 2, 3]
    arr << car

    assert_includes(arr, car)
  end
end
```
```ruby


class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end

  def test_car_exists
    assert(@car)
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end

  def test_name_is_nil
    assert_nil(@car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: "Joey")
    end
  end

  def assert_instance_of_car
    assert_instance_of(Car, @car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << @car

    assert_includes(arr, @car)
  end
end
```

## Testing Equality
How exactly is `assert_equal` testing for equality? Object equality? Value equality? Both?

`assert_equal` tests for _value equality_. It is invoking the `==` method on the object. For _object equality_ use the `assert_same` assertion.

#### Equality with a custom class
Essentially all we have to do is implement our own `==` method and Minitest will know how to compare objects of a custom class. 

## Code Coverage
_Code coverage_ is a measure of how much of our actual program code is tested by the test suite. This can be measured by many different standards and all they can do is check if there is a test for each bit of code. This does not mean that the tests themselves are good, work, or make any sense at all - just that we have at least one test for that line of code.

Use the `simplecov` gem to get a basic reports of your code coverage.
```bash
gem install simplecov
```
Then include
```ruby
SimpleCov.start
```
__at the very top__ of your test file. Next time the test is run, a folder called `coverage` will be created. Open up the `index.html` file and a report should display detailing your code coverage.

## Summary
* Minitest is the default testing library that comes with Ruby.
* Minitest test comes in 2 flavors: assert_style and spec-style. Unless you really like RSpec, use assert-style.
* A test suite contains many tests. A test can contain many assertions.
* Use the SEAT approach to writing tests.
* Use code coverage as a metric to gauge test quality. (But not the only metric.)
* Practice writing tests.