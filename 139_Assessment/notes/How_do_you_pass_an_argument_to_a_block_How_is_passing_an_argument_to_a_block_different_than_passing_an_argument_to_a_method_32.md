# How do you pass an argument to a block? How is passing an argument to a block different than passing an argument to a method?

```ruby
5.times do |num|
  ...
end
```
`num` in the above code is the argument that is passed into the block. This argument is able to be used because it is specified in the method when it yields to this block. So somewhere in the `#times` method there is a bit of code that looks something like `yield(number)` where `number` is the argument that is passed into the block. The `num` in the above code is a special type of local variable called a _block local variable_ where the __scope is constrained to the block__.

If too many arguments are passed to the block, then the extra arguments are ignored.
If too few arguments are passed to the block, then Ruby will use `nil`.

These argument rules are what makes using arguments with blocks different than using arguments with methods.

Ruby blocks have lenient arity rules. Procs and lambdas are two other way to implement the idea of _closure_ but behave differently when it comes to arguments.
