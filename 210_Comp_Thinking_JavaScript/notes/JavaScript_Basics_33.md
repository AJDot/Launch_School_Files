# JavaScript Basics

## Primitive Values are Immutable
JavaScript primitive types:
* number
* string
* boolean
* null
* undefined

This means you cannont change them once they are created. When the value of a string (or another primitive type) seemingly changes, JavaScript is actually assigns a completely new and different value to the variable. So always remember to assign an expression to change, **no method, function, or anything else will modify it for you**.

All other constructs, like arrays and functions, are mutable.

## Variables
### Declaring Variables
Variables must be declared before they are used.
```javascript
var myVariable;
var otherVariable;
var anotherVariable;
```

### Variable Assignment
Use the `=` operator
```javascript
var number;

number = 3;
```

This can be combined with the declaration.
```javascript
```

Note: Any variable declared but not assigned will be initialized to the value `undefined`.

### Dynamic Typing
JavaScript is a dynamically typed language - variables can hold a reference to any data type and reassigned to any data type without error.

## Operators
The arithmetic operators are as expected, like Ruby.

### Comparison Operators
Compares two operands and returns `true` or `false`. If the operands are of different types, JavaScript will try to implicitly convert them to suitable types. **This can use significant problems**. Many programmers avoid using `==` and `!=` for this reason, in favor of `===` and `!==`.

| Operator | Description |
| -------- | ----------- |
| Equal (==) | Returns true if the operands are equal |
| Not Equal (!=) | Returns true if the operands are not equal |
| Strict Equal (===) | Returns true if the operands are equal and of the same type |
| String Not Equal (!==) | Returns true if the operands are not equal and/or not of the same type |
| Greater than (>) | Returns true if the left operand is greater than the right |
| Less than (<) | Returns true if the left operand is less than the right |

## Expressions and Statements
### Increment and Decrement Operators in Expressions
(++) and (--) change the value of their operands by 1. They can appears as a prefix or postfix of the operand. However, **in more complex expressions** the two options behave a little differently.

* If the operator appears after the operand, JavaScript evaluates the expression, then modifies the operand.
* If the operator appears before the operand, JavaScript modifies the operand, then evaluates the expression.

### Logical Short Circuit Evaluation in Expressions
JavaScript evaluates the minimal amount of a logical expression. Examples:
```javascript
var a = true;
var b = false;

a || (b = true);      // b is still false after this, because (b = true) is never evaluated
b && (a = 1);         // a is still true after this, because (a = 1) is never evaluated
```

### Statements

```javascript
var a;        // a statement to declare variables
var b;
var c;
var b = (a = 1);        // this works, because assignments are expression too
```

Other statements are `if ... else ...` and `switch` for branching logic (conditionals), `while` and `for` for looping.

## Input and Output
`prompt()` method pops up a dialog box with an option message and asks for some text from the user.
```javascript
```
If `Cancel` is clicked in the dialog box, then `null` is returned.

### Using alert() to Prompt a Message to the User
`alert()` method displays a dialog with a message. Like `prompt()` but no input from the user.
```javascript
alert();
```

### Logging Debuggin Messages to the JavaScript Console
`console.log()` method outputs a message to the JavaScript console.
```javascript

```

## Practice Problems: Variables and Numbers
1. Declare a variable named `numerator` and set it to 10.
    ```javascript
    var numerator = 10;
    ```
2. Declare a variable name `denominator` and set it to 2.
    ```javascript
    var numerator = 10;
    var denominator = 2;
    ```
3. Declare a variable name `answer` and set it ot the result of `numerator` divided by `denominator`. Log the value of `answer` (it should be 5).
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    ```
4. Declare a variable named `incrementer` and set it to 1.
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    
    var incrementer = 1;
    ```
5. Declare a variable name `start` and set it to `incrementer`. 
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    
    var incrementer = 1;
    var start = incrementer;
    ```
6. Declare variables name `end` and `difference`. Leave them undefined. 
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    
    var incrementer = 1;
    var start = incrementer;
    var end;
    var difference;
    ```
7. Increment the `incrementer` varaible by 1 three times using the self-addition notation.
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    
    var incrementer = 1;
    var start = incrementer;
    var end;
    var difference;
    
    incrementer += 1;
    incrementer += 1;
    incrementer += 1;
    ```
8. Increment the `incrementer` variable by 1 twice using increment operator shorthand.
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    
    var incrementer = 1;
    var start = incrementer;
    var end;
    var difference;
    
    incrementer += 1;
    incrementer += 1;
    incrementer += 1;
    
    incrementer++;
    incrementer++;
    ```
9. Set the value of `end` to `incrementer` and the value of `difference` to `end` minus `start`. Log the value of `end`, which should be 6. Log the value of `difference`, which should be 5.
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    
    var incrementer = 1;
    var start = incrementer;
    var end;
    var difference;
    
    incrementer += 1;
    incrementer += 1;
    incrementer += 1;
    
    incrementer++;
    incrementer++;
    
    end = incrementer;
    difference = end - start;
    ```
10. `answer` = 11 plus 31 multiplied by 3 as one statement.
    ```javascript
    var numerator = 10;
    var denominator = 2;
    var answer = numerator / denominator;
    console.log(answer);
    
    var incrementer = 1;
    var start = incrementer;
    var end;
    var difference;
    
    incrementer += 1;
    incrementer += 1;
    incrementer += 1;
    
    incrementer++;
    incrementer++;
    
    end = incrementer;
    difference = end - start;
    
    answer = (11 + 31) * 3;
    ```

## Explicit Primitive Type Coercions
Converting from one type to another is called a **coercion** or **conversion**. Since primitives in JavaScript are immutable, nothing is actually converted, instead a new value of the new type is returned.

### Converting Strings to Numbers
```javascript
```

### Converting Numbers to Strings
```javascript
String(123);          // "123"
String(1.23);         // "1.23"
(123).toString();     // "123"
(123.12).toString();  // "123.12"
```

### Booleans to Strings
```javascript
String(true);       // "true"
String(false);      // "false"
true.toString();    // "true"
false.toString();   // "false"
```

### Primitives to Booleans
No way to coerce a String into a boolean, so a string must be compared to another string. Keep in mind that "true" is not equal to "TRUE".
```javascript
```
`Boolean()` can be used to convert any value into a boolean using the `truthy` and `falsy` rule in JavaScript.
```javascript
Boolean(null);            // false
Boolean(NaN);            // false
Boolean(0);            // false
Boolean(false);            // false
Boolean(undefined);            // false
Boolean(123);            // true
```

Use the double `!` operator to coerce a truthy or falsy value to its boolean equivalent.
```javascript
!!(null);       // false
!!(NaN);        // false
!!(0);          // false
!!(false);      // false
!!(undefined);  // false

!!(123);        // true
```

## Implicit Primitive Type Coercions
### The Plus (+) Operator
Tries to convert values into numbers:
```javascript
+(null)         // 0
```

When used with two operands and one is a string, JavaScript tries to convert the other to a string.
```javascript
1 + true          // 2
123 + "123"       // "123123"
```

### Other Arithmetic Operators
`-`, `*`, `/`, `%`, are only defined for numbers, so JavaScript will try to coerce operands to numbers:
```javascript
1 - true          // 0
```

### Relational Operators
`<`, `>`, `<=`, `>=` are defined for numbers and strings. Generally, JS tries to convert operands into numbers unless both operands are strings.
```javascript
```

### Equality Operators
#### Non-strict equality operators
```javascript
0 == false        // true - false is coerced into a number 0
true == 1         // true - comparison of a boolean and a non-boolean will coerce the boolean to a number
```

#### Strict equality operators
```javascript
0 === false        // false
true === 1         // false
```

### Best Practices
* **Always use explicit type coercions**
* **Always use strict equality operators** (`===` and `!==`)

## Conditionals
### if...else
```javascript
var score = 80;

if (score > 70) {
}
```

```javascript
if (score > 70) {
} else {
}
```

```javascript
if (condition1) {
  // statements
} else if (conditional2) {
  // statements
} else if (conditionN) {
  // statements
}
```

### Truthy and Falsy
These are the only 6 possible "falsy" values (include the boolean `false`).
```javascript
if (false)      // falsy
if (null)       // falsy
if (undefined)  // falsy
if (0)          // falsy
if (NaN)        // falsy
```
Everything else is "truthy"

### Switch
```javascript

switch (reaction) {
    break;
    break;
    break;
  default:
}

// console output
The sentiment of the market is negative
```

### Comparing values with NaN
`NaN` is a special value that represents an illegal operation on numbers. It stands for "Not a Number" but it is considered a number in JavaScript. `console.log(typeof(NaN)); // number`

A big problem with `Nan` is that a comparison to it will always evaluate to `false` even if compared to another`NaN`. So `NaN` is not equal to `NaN`.

So to check if a variable holds a `NaN`, use the function `isNaN` which returns `true` if a value is not a number, `false` otherwise. And this is literal, even a string will evaluate to `true` because it is not a number.

```javascript
var foo = NaN;
console.log(isNaN(foo));      // true
console.log(isNaN("hello"));  // true
```

To solve this elegantly, `NaN` is not equal to itself, so make a function to test this.

```javascript
function isValueNaN(value) {
  return value !== value;
}

// A more explicit check that the argument is numeric
function isValueNaN(value) {
  return typeof value === "number" && isNaN(value);
}
```

## Looping and Iteration
### The "while" Loop
```javascript
var counter = 0;
var limit = 10;

while (counter < limit) {
  console.log(counter);
  counter += 2;
}
```

### Break and Continue
The `break` statement exits from a loop immediately;
```javascript
var counter = 0;
var limit = 10;

while (true) {
  counter += 2;
  if (counter > limit) {
    break;
  }

  console.log(counter);
}
```

The `continue` statement skips the current iteration of a loop and return to the top of the loop.
```javascript
var counter = 0;
var limit = 10;

while (true) {
  counter += 2;
  if (counter === 4) {
    continue;
  }

  if (counter > limit) {
    break;
  }

  console.log(counter);
}
```

### The "do...while" Loop
Similar to the `while` loop but it ensures the code is executed at least once.
```javascript
var counter = 0;
var limit = 0;

do {
  console.log(counter);
  counter++;
} while (counter < limit);
```

### The "for" Loop
```javascript
for (initialExpression; condition; incrementExpression) {
  // statements
}

for (var i = 0; i < 10; i++) {
  console.log(i);
}
```