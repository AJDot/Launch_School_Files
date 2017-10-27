# Explain the difference in arity rules between blocks, procs, and lambdas.

```ruby
proc { |thing| puts "This is a #{thing}." }
```
* This is a Proc object.
* Outputting it is like outputting any object except it will contain what file it came from. 


|   | Block | Proc | Lambda |
| - | ----- | ---- | ------ |
| Class | Proc - if used explicitly by method. Implicit block is not an Object | Proc | Proc | 
|Too few arguments | Will use `nil` for unspecified arguments | Will use `nil` for unspecified arguments | Error will be thrown |
|Too many arguments | Will ignore extra arguments | Will ignore extra arguments | Error will be thrown |
| yield with no block given | JumpError will be thrown | - | - |
| no yield with block given | Block will be ignored | - | - |
