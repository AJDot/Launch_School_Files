# Functions and Variable Scope
## Defining Functions
```javascript
function triple(number) {
  return number + number + number;
}
```

NOTE: If an explicit `return` statement is not used, the function will implicitly return the value `undefined`.

## Parameters vs. Arguments
```javascript
function multiply(a, b) {
  return a * b;
}
```
In the above code `a` and `b` are parameters of the function.

```javascript
multiply(5, 6);
```


| If you are... | Then you should use... |
| ------------- | ---------------------- |
| **Defining** a function | *parameters* |
| **Invoking** a function | *arguments* |

## Function Invocations and Arguments
The standard way to invoke a function is to append `()` to it.

```javascript
function takeTwo(a, b) {
  console.log(a);
  console.log(b);
  console.log(a + b);
}

takeTwo(1);

// logs:
1
undefined
NaN
```
NOTE:
1. Calling a function with too few arguments *does not raise an error*.
4. If more arguments are passed to a function, then they are simply ignored.

## Nested Functions
You can do it.
```javascript
function circumference(radius) {
  function double(number) {           // nested function:
    return 2 * number;
  }
  
  return 3.14 * double(radius);       // call the nested function
}
```

## Functional Scopes and Lexical Scoping
In JavaScript, every Function creates a new variable scope.

### The Global Scope
```javascript
console.log(name);

for (var i = 0; i < 3; i++) {
  console.log(name);
}

console.log(name);
```
With no functions, there is a single, global scope. After `name` is defined, it is available everywhere.

### Function Scope
```javascript

function greet() {
  console.log(name);
}
```
`greet()` Function can access `name` since the coe within a Function inherits access to all variables in all surrounding scopes.

You can visually think of Functions scopes as nested inside each other. Inner nested Functions have access to variables declared in outer nested Functions (relative to the inner nested Function). This works no matter how deeply nested a Function is.

### Closures
Think of a Function as *closing over* the current variable scope. This is called *creating a closure*. **A closure retains references to everything that is in scope when the closure is created, and retains those references for as long as the closure exists.**

If the **value** of a variable changes after creating a closure that includes that variable, the closures sees the new value and the old value is no longer available.
```javascript
var count = 1;

function logCount() { // create a closure
  console.log(count);
}

logCount();            // logs: 1

count++;               // reassign count
logCount();            // closure sees new value for count; logs: 2
```

### Lexical Scoping

JavaScript searches the hierarchy from bottom to top; it stops and returns the first variable it finds with a matching name. **Lower scope can *shadow* a variable with the same name in a higher scope.**

### Adding Variables to Current Scope
1. Use the `var` keyword.
2. Use an argument passed into a Function. Parameters create variables during Function invocation

### Variable Assignment
Scoping applies to both assignment and referencing.
If a variable is reassigned, JavaScript will search for the nearest scoped variable with the matching name and assign the new value to it. If it does not find a match, **it creates a new global variable instead**. (This is what happens when you forget to use the `var` keyword.

## Function Declarations and Function Expressions
The accessibility of a function is determined that same way as for variables. Functions defined in an inner scope are not accessible in an outer scope.

### Function Expressions
```javascript
var hello = function() {
};

console.log(typeof hello);    // function
console.log(hello());         // hello
```
An anonymous function is assigned to the variable `hello`.

### Name Function Expressions
```javascript
var hello = function foo() {
  console.log(typeof foo);  // function
};

hello();

foo();                      // Uncaught ReferenceError: foo is not defined
```

## Hoisting
### Hoisting for Variable Declarations
JavaScript declares variables before executing any code within a scope. Declaring a variable anywhere in the scope is the same as declaring it at the top of the scope. This is called **hoisting**. Note that assignment is not hoisted, just **declaration**.
```javascript
console.log(a)  // Will this code execute? What will it log?
var a = 123;
var b = 456;
```
Is the same as
```javascript
var a;          // Hoisted to the top of the global scope
var b;

console.log(a)  // Logs `undefined`
a = 123;
b = 456;
```

### Hoisting for Function Declarations
Functions expression involve assigning a function to a declared variable. These are just variable declarations and thus obey theh rules stated above.

### Hoisting Variable and Function Declarations
When both variable and function declarations exist, function declarations are processed first.
```javascript
bar();   // logs undefined

function bar() {
  console.log(foo);
}
```
Is the same as
```javascript
function bar() {
  console.log(foo);
}

var foo;

bar();  // logs undefined
```

### Best Practice to Avoid Confusion
* Always declare variables at the top of their scope.
* Always declare function before calling them.

For more about hoisting [javascriptweblog](https://javascriptweblog.wordpress.com/2010/07/06/function-declarations-vs-function-expressions/).
