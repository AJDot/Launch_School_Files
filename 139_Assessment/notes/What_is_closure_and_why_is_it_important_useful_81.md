# What is closure and why is it important/useful?
Closure is the concept of being able to save a "chunk of code" and execute it at a later time. In this sense, a closure _encloses_ a section code and effectively saves the state of the program necessary for the proper execution of that code at a later time/place. 

One interesting feature of closures is their ability to stay updated even after variables inside of it have been altered after the closure has been defined. A closure is implemented through a `Proc` object.

The purpose of closures is to allow for sections of code to be passed around to different parts of the program. For example:
```ruby
[1, 2, 3, 4, 5].select do |num|
  (num ** 2) > 10 # => [4, 5]
end
```
The block portion of this code (between the `do...end`) is _passed into_ the `#select` method and executed when yielded to. At this moment the program leaves the method and executes the code in the block. Of course with `#select` the return value of the block is used to determine if a number should be selected. We can take this same code and pass it into another method.
```ruby
[1, 2, 3, 4, 5].count do |num|
  (num ** 2) > 10 # => 2
end
```
Now we are counting numbers that have squares greater than 10 instead of selecting them. 

We can set this block up as a `Proc` object and pass it around.
```ruby
square_greater_10 = Proc.new do |num|
  (num ** 2) > 10
end

[1, 2, 3, 4, 5].count(&square_greater_10)  # => 2
[1, 2, 3, 4, 5].select(&square_greater_10) # => [4, 5]
```
We have acccomplished reusing code by instantiating a `Proc` object with the code we want to run later. The code above can even work on a hash with numbered keys!
```ruby
hash.select(&square_greater_10) # => {4=>"d", 5=>"e"}
```


#### Why are closures useful?
One great use is when a section of code is used multiple times but may require small tweaks each time. We could write a method for each of these tweaks but that gets tedious and difficult to maintain. A closure allows us to implement that tweak on the fly. Example:
```ruby
def minimum(array)
  min = array[0]
  array.each do |item|
    min = item if item < min
  end
  min 
end
```
```ruby
def minimum_length(array)
  min = array[0]
  array.each do |item|
    min = item if item.length < min.length
  end
  min
end
```
```ruby
def minimum(array)
  min = array[0]
  if block_given?
    array.each do |item|
      min = item if yield(item) < yield(min)
    end
  else
    array.each do |item|
      min = item if item < min
    end
  end
  min
end

minimum([1, 2, 3, 4, 5])                                                # => 1
minimum([1, 2, 3, 4, 5]) { |num| -num}                                  # => 5
```
Amazing! Now we have just one method but can utilized the comparison in many ways.