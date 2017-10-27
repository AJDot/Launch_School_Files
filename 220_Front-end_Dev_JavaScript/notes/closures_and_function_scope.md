# Closures and Function Scope

## Closures and Function Review
Functions can be defined using two different syntaxes:

```javascript
// This is the named function syntax
function hello() {
  console.log('Welcome!');
}

// This is the function expression syntax
var hello = function() {
  console.log('Welcome!');
}
```

**Function expression** syntax is useful when passing a function to another function as an argument or return value.

```javascript
var squares = [1, 2, 3, 4, 5].map(function(number) {
  return math.Pow(number, 2);
});
```
All functions obey these lexical scoping rules:

* It can access any variables defined within it.
* It can access any variables that were in scope based on the context where the function was defined.

## Higher-Order Functions
**Higher-order functions** either accept a function as an argument or return a function when invoked. These functions work with other functions.

Built-in example: `forEach` takes a function as an input:
```javascript
// function passed as an argument
[1, 2, 3, 4].forEach(function(number) {
  console.log(number);
});
```
But functions can also return functions.
```javascript
// function as return value
function helloFactory(){
  return function() {
    console.log("hi");
  }
}
```

Higher-order functions can do both, take a function as input and return a function. `timed` below takes a function and records how long it takes to run it.
```javascript
function timed(func) {
  return function() {
    var start  =new Date();
    func();
    var stop = new Date();
    console.log((stop - start).toString() + " ms have elapsed.");
  }
}
```

Pass a function as the argument and save the return as a variable. Then call it.
Example:
```javascript
function loopy() {
  var sum = 0;
  for (var i = 0; i < 1000000000; i++) {
    sum += i;
  }
  console.log(sum);
}
```

```
> timed(loopy)();     // Immediate invocation of returned function
499999999067109000
675 ms have elapsed.
```

## Practice Problems: Higher-Order Functions

1. What are the two characteristics that define higher-order functions?
Solution
They can take a function as an argument and/or return a function.

2. Consider the code below:

  ```javascript
  var numbers = [1, 2, 3, 4];
  function checkEven(number) {
    return number % 2 === 0;
  }

  numbers.filters(checkEven); // (2) [2, 4]
  ```

  Solution
  `filter` is a higher order function because it takes a function as an argument.

3. Implement `makeCheckEven` below, such that the last line of the code returns an array `[2, 4]`.

  ```javascript
  var numbers = [1, 2, 3, 4];
  function makeCheckEven() {
    // ... implement this function
  }

  var checkEven = makeCheckEven();

  numbers.filter(checkEven); // (2) [2, 4]
  ```
Solution
  ```javascript
  var numbers = [1, 2, 3, 4];
  function makeCheckEven() {
    return function(number) {
      return number % 2 === 0;
    }
  }

  var checkEven = makeCheckEven();

  numbers.filter(checkEven); // (2) [2, 4]
  ```

4. Implement execute below, such that the return values for the two function invocations match the commented values.

```javascript
function execute(func, operand) {
  // implement this function...
}

execute(function(number) {
  return number * 2;
}, 10); // 20

execute(function(string) {
  return string.toUpperCase();
}, 'hey there buddy'); // HEY THERE BUDDY
```

Solution
```javascript
function execute(func, operand) {
  return func(operand);
}

execute(function(number) {
  return number * 2;
}, 10); // 20

execute(function(string) {
  return string.toUpperCase();
}, 'hey there buddy'); // HEY THERE BUDDY
```

5. Implement `makeListTransformer` below such that `timesTwo`'s return value matches the commented return value.

```javascript
function makeListTransformer(func) {
  return function(collection) {
    return collection.map(func);
  }
}

var timesTwo = makeListTransformer(function(number) {
  return number * 2;
});

timesTwo([1, 2, 3, 4]); // [2, 4, 6, 8]
```

Solution

```javascript
function makeListTransformer(func) {

}

var timesTwo = makeListTransformer(function(number) {
  return number * 2;
});

timesTwo([1, 2, 3, 4]); // [2, 4, 6, 8]
```

## Closures and Private Data

Functions are **closures** - they *close over* or *enclose* the context at their definition point. They **always** have access to that context.

Example:
```javascript
function makeCounter() {
  var count = 0;      // declare a new variable
  return function() {
    count += 1;       // references count from the outer scope
    console.log(count);
  }
}
```

```bash
> var counter = makeCounter();
> counter();
1
> counter();
2
> counter();
3
```

**NOTE**: It is *impossible* to access the value of `count` from outside the closure.
```javascript
var counter = makeCounter();

// ReferenceError: count is not defined
console.log(count);
// undefined: variable with closures aren't accessible from outside
console.log(counter.count);
```

### Problems

1. Create a `makeCounterLogger` function that takes a number as an argument and returns a function. When we invoke the returned function with a second number, it should count up or down from the first number to the second number, logging each number to the console:

```bash
> var countlog = makeCounterLogger(5);
> countlog(8);
5
6
7
8
> countlog(2);
5
4
3
2
```
Solution
```javascript
function makeCounterLogger(start) {
  return function(stop) {
    var i;
    if (stop > start) {
      for (i = start; i <= stop; i++) {
        console.log(i);
      }
    } else {
      for (i = start; i >= stop; i--) {
        console.log(i);
      }
    }
  }
}
```

2. We'll build a simple todo list program using the techniques we've seen in this assignment. Write a `makeList` function that returns a new function that implements a todo list. The returned function should have the following behavior:

* When called with an argument that is not already on the list, it adds that argument to the list.
* When called with an argument that is already on the list, it removes the element from the list.
* When called without arguments, it logs all items on the list. If the list is empty, it logs an appropriate message.
```bash
> var list = makeList();
> list();
The list is empty.
> list("make breakfast");
make breakfast added!
> list("read book");
read book added!
> list();
make breakfast
read book
> list('make breakfast');
make breakfast removed!
> list();
read book
```

Solution
```javascript
function makeList() {
  var collection = [];
  return function(item) {
    var index;
    if (item) {
      index = collection.indexOf(item);
      if (index === -1) {
        collection.push(item);
        console.log(item + " added!");
      } else {
        collection.splice(index, 1);
        console.log(item + " removed!");
      }
    } else {
      if (collection.length === 0) {
        console.log("The list is empty.");
      } else {
        collection.forEach(function(item) {
          console.log(item)
        });
      }
    }
  };
}
```

## Practice Problems: Closures

1. Write a function named `makeMultipleLister` that, when invoked and passed a number, returns a function that logs every positive integer multiple of that number less than 100. Usage looks like this:

```bash
> var lister = makeMultipleLister(13);
> lister();
13
26
39
52
65
78
91
```
Solution
```javascript
function makeMultipleLister(number) {
  return function() {
    var i = number;
    while (i <= 100) {
      console.log(i);
      i += number;
    }
  };
}
```


2. Write a program that uses two functions, `add` and `subtract`, to manipulate a running total value. When you invoke either function with a number, it should add or subtract that number to the running total and log the new total to the console. Usage looks like this:

```bash
> add(1)
1
> add(42);
43
> subtract(39);
4
> add(6);
10
```

Solution
```javascript
var total = 0;

function add(number) {
  total += number;
  console.log(total);
}

function subtract(number) {
  total -= number;
  console.log(total);
}
```

3. Write a function named `later` that takes two arguments: a function and an argument for that function. The return value should be a new function that calls the input function with the provided argument, like this:

```bash
> var logWarning = later(console.log, 'The system is shutting down!');
> logWarning()
The system is shutting down!
```

Solution
```javascript
function later(func, arg) {
  return function() {
    return func(arg);
  }
}
```
> We call this **partial application**: the original function already has some of its arguments defined. In effect, the program partially applies them ahead of time. Since you already have their values, you don't need to provide them when you invoke the function.
>
> Here, later partially applies functions that take a single argument. You can use partial application with functions that take any number of arguments; you can provide any arguments ahead of time, and the others when you invoke the returned function.

4. Given the following code:
```javascript
function startup() {
  var status = 'ready';
  return function() {
    console.log('The system is ready.');
  }
}

var ready = startup();
var systemStatus = // ?
```

How can you set the value of `systemStatus` to the value of the inner variable `status` without changing `startup` in any way?

Solution
You can't. **There is no way to access this value from outside the function**. Variables inside closures are available to the closure never outside it.

This technique lets us define "private" variables.
