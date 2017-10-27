# Explain the difference in return values between blocks, procs, and lambdas.

|   | Block | Proc | Lambda |
| - | ----- | ---- | ------ |
| Defined inside method & `return` inside it |  | Will return from method immediately | Will _not_ return from method immediately - following code will execute |