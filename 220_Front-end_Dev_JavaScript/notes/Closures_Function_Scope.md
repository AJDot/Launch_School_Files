# Closures and Function Scope

<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Closures and Function Scope](#closures-and-function-scope)
  * [Closures and Function Review](#closures-and-function-review)
  * [Higher-Order Functions](#higher-order-functions)
  * [Practice Problems: Higher-Order Functions](#practice-problems-higher-order-functions)
  * [Closures and Private Data](#closures-and-private-data)
    * [Problems](#problems)
  * [Practice Problems: Closures](#practice-problems-closures)
  * [Objects and Closures](#objects-and-closures)
    * [Problems](#problems-1)
    * [Why use closures to make data private?](#why-use-closures-to-make-data-private)
  * [Project: Banking with Objects and Closures](#project-banking-with-objects-and-closures)
  * [Garbage Collection](#garbage-collection)
  * [How Closures Affect Garbage collection](#how-closures-affect-garbage-collection)
    * [Problems](#problems-2)
  * [Practice Problems: Garbage Collection](#practice-problems-garbage-collection)
  * [Partial Function Application](#partial-function-application)
    * [Problems](#problems-3)
  * [Practice Problems: Partial Function Application](#practice-problems-partial-function-application)
  * [Immediately Invoked Function Expressions](#immediately-invoked-function-expressions)
  * [Creating a Private Scope with an IIFE](#creating-a-private-scope-with-an-iife)
  * [Practice Problems: IIFEs](#practice-problems-iifes)
  * [Summary](#summary)

<!-- tocstop -->
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

## Objects and Closures

Take the `makeList` code:
```javascript
function makeList() {
  var items = [];

  return function(newItem) {
    var index;
    if (newItem) {
      index = items.indexOf(newItem);
      if (index === -1) {
        items.push(newItem);
        console.log(newItem + " added!");
      } else {
        items.splice(index, 1);
        console.log(newItem + " removed!");
      }
    } else {
      if (items.length === 0) {
        console.log("The list is empty.");
      } else {
        items.forEach(function(item) {
          console.log(item);
        });
      }
    }
  };
}
```

The solution is concise but *unclear*. Instead of using it like `list('breakfast')` which can both add that item and also delete it if it exists, it would be clearer if there was an API that was easy to use and understand.

```bash
> var list = makeList();
> list.add("peas");
peas added!
> list.list();
peas
> list.add("corn");
corn added!
> list.list();
peas
corn
> list.remove("peas");
peas removed!
> list.list();
corn
```

### Problems
1. Reimplement `makeList`, so it returns an Object that provides the interface shown above, including `add`, `list`, and `remove` methods.

```javascript
function makeList() {
  return {
    items: [],

    add: function(item) {
      var index = this.items.indexOf(item);
      if (index === -1) {
        this.items.push(item);
        console.log(item + " added!");
      }
    },

    list: function() {
      if (this.items.length === 0) {
        console.log("The list is empty.");
      } else {
        this.items.forEach(function(item) {
          console.log(item);
        });
      }
    },

    remove: function(item) {
      var index = this.items.indexOf(item);
      if (index !== -1) {
        this.items.splice(index, 1);
        console.log(item + " removed!");
      }
    },
  };
}
```

2. Update the implementation from problem 1 so that it retains the use of an object with methods but prevents outside access to the items the object stores internally.

```javascript
function makeList() {
  var items = [];

  return {
    add: function(item) {
      var index = items.indexOf(item);
      if (index === -1) {
        items.push(item);
        console.log(item + " added!");
      }
    },

    list: function() {
      if (items.length === 0) {
        console.log("The list is empty.");
      } else {
        items.forEach(function(item) {
          console.log(item);
        });
      }
    },

    remove: function(item) {
      var index = items.indexOf(item);
      if (index !== -1) {
        items.splice(index, 1);
        console.log(item + " removed!");
      }
    },
  };
}
```

### Why use closures to make data private?
* It forces other developers to use the intended interface. The above coded enforced access to the data through the provided methods.
* Helps protect data integrity. We are forced to use `add` to add an item which ensures that every addition is logged.
* This can however make extending the code harder.
```javascript
var list = makeList();
list.clear = function() {
  // there is no way to access the items from within this method
  // because the closure that contains them in inaccessible

  items           // => throws Reference error!
  this.items      // => undefined
};
```

To add the method, the original definition of `makeList` must be updated.

## Project: Banking with Objects and Closures
1. Create an object named `account` that represents a bank account. It should contain a `balance` property that stores the account's current balance.
```javascript
var account = {
  balance: 0,
}
```

2. Add a `deposit` method to the `account` object that takes a single argument, the amount of the deposit. Add it to the account's balance, and return the same amount.
```javascript
var account = {
  balance: 0,
  deposit: function(amount) {
    this.balance += amount;
    return amount;
  }
}
```

3. Add a `withdraw` method to the `account` object that takes a single argument, the amount to withdraw. It should subtract the amount from the account's balance and return the amount subtracted:
```javascript
var account = {
  balance: 0,
  deposit: function(amount) {
    this.balance += amount;
    return amount;
  },
  withdraw: function(amount) {
    if (amount > this.balance) {
      amount = this.balance;
    }
    this.balance -= amount;
    return amount;
  },
}
```

4. Each account should have a record of every deposit and withdrawal applied to it. To do this, add a property named `transactions` to `account` that contains an Array of transactions, each of which is an Object with `type` and `amount` properties:
```javascript
var account = {
  balance: 0,
  transactions: [],
  deposit: function(amount) {
    this.balance += amount;
    this.transactions.push({type: "deposit", amount: amount})
    return amount;
  },
  withdraw: function(amount) {
    if (amount > this.balance) {
      amount = this.balance;
    }
    this.balance -= amount;
    this.transactions.push({type: "withdraw", amount: amount})
    return amount;
  },
}
```

5. We want to create more than one account. Move the account creation code to a function named `makeAccount` that returns a new account object:
```javascript
function makeAccount() {
  return {
    balance: 0,
    transactions: [],
    deposit: function(amount) {
      this.balance += amount;
      this.transactions.push({type: "deposit", amount: amount})
      return amount;
    },
    withdraw: function(amount) {
      if (amount > this.balance) {
        amount = this.balance;
      }
      this.balance -= amount;
      this.transactions.push({type: "withdraw", amount: amount})
      return amount;
    },
  }
}

var account = makeAccount();
```

6. We also need an object to manage accounts: a bank. Create a function that returns an object that represents a bank. The bank should have a property named `accounts` that represents a list of accounts:
```javascript
function makeBank() {
  return {
    accounts: [],
  }
}
var bank = makeBank();
```

7. Add a new method named `openAccount` to the object returned by `makeBank`. It should create a new account, add it to the bank's `accounts` collection, and return the new account. Each new account should have a unique account number, starting at 101; each account number should be one greater than the previous account created.
```javascript
function makeAccount(number) {
  return {
    number: number,
    balance: 0,
    transactions: [],
    deposit: function(amount) {
      this.balance += amount;
      this.transactions.push({type: "deposit", amount: amount})
      return amount;
    },
    withdraw: function(amount) {
      if (amount > this.balance) {
        amount = this.balance;
      }
      this.balance -= amount;
      this.transactions.push({type: "withdraw", amount: amount})
      return amount;
    },
  }
}
function makeBank() {
  return {
    accounts: [],
    openAccount: function() {
      var number = this.accounts.length + 101;
      var account = makeAccount(number);
      this.accounts.push(account);
      return account;
    }
  }
}
var bank = makeBank();
```

8. Add a new method to the bank object that transfers money from one account to another:
```javascript
function makeBank() {
  return {
    accounts: [],
    openAccount: function() {
      var number = this.accounts.length + 101;
      var account = makeAccount(number);
      this.accounts.push(account);
      return account;
    },
    transfer: function(source, destination, amount) {
      return destination.deposit(source.withdraw(amount));
    }
  }
}
var bank = makeBank();
```

9. Change the code so that users can access the account balance, account number, and transactions list by calling methods, but not by directly accessing those properties.

```javascript
function makeBank() {
  function makeAccount(number) {
    var balance = 0;
    var transactions = [];

    return {
      deposit: function(amount) {
        balance += amount;
        transactions.push({type: "deposit", amount: amount})
        return amount;
      },
      withdraw: function(amount) {
        if (amount > balance) {
          amount = balance;
        }
        balance -= amount;
        transactions.push({type: "withdraw", amount: amount})
        return amount;
      },
      balance: function() {
        return balance;
      },
      number: function() {
        return number;
      },
      transactions: function() {
        return transactions;
      },
    };
  }

  return {
    accounts: [],
    openAccount: function() {
      var nextId = this.accounts.length + 101;
      var account = makeAccount(nextId);
      this.accounts.push(account);
      return account;
    },
    transfer: function(source, destination, amount) {
      return destination.deposit(source.withdraw(amount));
    }
  }
}
```

10. Change the code so that users can no longer access the list of accounts.
```javascript
function makeBank() {
  var accounts = [];

  function makeAccount(number) {
    var balance = 0;
    var transactions = [];

    return {
      deposit: function(amount) {
        balance += amount;
        transactions.push({type: "deposit", amount: amount})
        return amount;
      },
      withdraw: function(amount) {
        if (amount > balance) {
          amount = balance;
        }
        balance -= amount;
        transactions.push({type: "withdraw", amount: amount})
        return amount;
      },
      balance: function() {
        return balance;
      },
      number: function() {
        return number;
      },
      transactions: function() {
        return transactions;
      },
    };
  }

  return {
    openAccount: function() {
      var nextId = accounts.length + 101;
      var account = makeAccount(nextId);
      accounts.push(account);
      return account;
    },
    transfer: function(source, destination, amount) {
      return destination.deposit(source.withdraw(amount));
    }
  }
}
```

## Garbage Collection

JavaScript is a **garbage-collected** language - it automatically cleans up values and objects when teh program no longer needs them.

Without GC, the developer must write code to allocate (claim) and deallocate (unclaim or release) memory. This is error-prone and can lead to "memory leaks".

Without automatic GC...
* Must claim memory amount for a variable to reference
* Must handle allocation errors
* Must copy data into memory referenced by variable
* Then do something with object (the only part we do in JavaScript)
* Must release memory for use by others

But JS is a garbage-collected language so this is not done by the developer. JS will only make memory eligible for garbage collection if there are no variables, object, or closures that maintain a reference to the object or value in that allocated memory.

If the object or value is accessible by the program, then JavaScript can't and won't garbage collect it.

```javascript
function logName() {
  var name = "Sarah"; // Declare a variable and set its value. The JavaScript
                      // runtime automatically allocates the memory.
  console.log(name);  // Do something with name
  return name;        // Returns "Sarah" to caller
}

var loggedName = logName(); // loggedName variable is assigned the value "Sarah"
                            // the "Sarah" assigned to `loggedName` is NOT eligible for GC
                            // the "Sarah" assigned to `name` IS eligible for GC
// more code below this line
```

> You may sometimes hear it said that garbage collection occurs when a variable goes out of scope. That's wrong; a variable can go out of scope (i.e. `name`), but references to the object or value that it referenced may still exist elsewhere. Of course, if the variable is the sole remaining reference to the object or value, then it does become eligible for GC.

## How Closures Affect Garbage collection

When a closure is created, it stores a reference to all variables it can access. Theoretically, as long as the closure exists, all those variables must exist, so the objects or values they reference must also exist, therefore JavaScript can't garbage collect any of it.

Theory and practice aren't always equal. [This post](https://stackoverflow.com/questions/24468713/javascript-closures-concerning-unreferenced-variables) describes when a value should not be garbage collected but might be anyway.

```javascript
function makeHello(name) {
  return function() {
    console.log("Hello, " + name + "!");
  }
}

var helloSteve = makeHello("Steve");
```
`name` and the reference to "Steve" must be kept around.

To remove a closure and effectively release the variables only referenced in that closure, assign `null` to it.
```javascript
helloSteve = null;
```
If nothing else has a reference to `"Steve"`, it will be garbage collected.

### Problems
1. In the following code, when can JavaScript garbage collect the values represented by the variables `a`, `b`, and `c`?
```javascript
var a = 34;

function add(b) {
  a += b;
} // The value of b is eligible for GC when this function returns

function run() {
  var c = add(4);
} // The value of c is eligible for GC when this function returns

run();
// The value of a is eligible for GC when the program finishes running
```

2. In the following code, when can JavaScript garbage collect the value `"Steve"`?
```javascript
function makeHello(name) {
  return function() {
    console.log("Hello, " + name + "!");
  }
}

var helloSteve = makeHello("Steve");
```
It is eligible only after the program finishes (after JS GC collects the function referenced by `helloSteve`).

## Practice Problems: Garbage Collection
1. Is javaScript a garbge-collected language, and if so, what does this entail?

Yes. This means JavaScript will "automatically" allocate and release memory for values.

2. Consider teh code below:
```javascript
var myNum = 1;

function foo() {
  var myStr = "A string";
  // what is eligible for GC here?
}

foo();

// what is eligible for GC here?

// more code
```
Are either of the values `1` or `"A string"` eligible for garbage collection on line 5? What about on line 10?

Answer: Neither is eligible on line 5, `"A string"` is eligible on line 10.

3. In the code below, is the value referenced by `outerFoo` eligible for garbage collection on line 10?
```javascript
var outerFoo;

function bar() {
  var innerFoo = 0;
  outerFoo = innerFoo;
}

bar();

// can outerFoo's 0 be garbage collected here?

// more code
```
Answer: No, `innerFoo`'s copy of `0` can be because it is Function-scoped but `outerFoo`'s copy can't because it is a global variable.
4. Consider the code below:
```javascript
function makeEvenCounter() {
  var index = 0;
  return function() {
    return index += 2;
  }
}

var evenCounter = makeEvenCounter();

// is 0 eligible for GC here?

// more code
```
Is `0` eligible for garbage collection on line 10?

Answer: No. The closure created on the function returned by `makeEvenCounter` on line 8 prevents `0` from being garbage collected.

5. Consider the script below:
```javascript
var bash = "Some val";
```
Will the value "Some val" ever be eligible for garbage collection?

Answer: Yes. If `bash` is assigned to another value, like `null`, then `"Some val"` can be garbage-collected.
LS Answer: Yes. After the script finishes running the value will be eligible for garbage collection.

## Partial Function Application

Partial function application uses a function (called the *generator*) to create a new function (the *applicator*) to call a third (the *primary*) that the generator receives as an argument. The generator receives some of the primary's arguments and the applicator receives the rest when it is invoked. Then the applicator calls the primary and passes it all its, both those passed to the generator and the applicator.
```javascript
function primary(arg1, arg2) {        // primary function
  ...
}

function generator(primary, arg1) {   // generator function
  return function(arg2) {             // applicator function
    return primary(arg1, arg2);
  }
}

var partialFunction = generator(primary, "Hello");
partialFunction(37.2);                // Like primary("hello", 37.2)
```
Example:
```javascript
function add(first, second) {
  return first + second;
}

function makeAddN(addend) {       // generator
  // Save addend via closure; uses addend when function invoked.
  return function(number) {       // applicator
    return add(addend, number);   // call primary
  }
}

var add1 = makeAddN(1);
add1(1)                           // => 2
add1(41)                          // => 42

var add0 = makeAddN(9);
add9(1);                          // => 10
add9(9);                          // => 18
```
The closure "carries" a reference to the variable `addend`, a local variable in `makeAddN`.

Closures allow us to define private data that persists for the function's lifetime. Data and functionality can be packaged together. The function can be passed around without losing the private data.

Downside: not reusable. Have to create new generator for `multiply`.

This technique can be generalized a bit to allow other functions to be passed into the generator.
```javascript
function add(first, second) {
  return first + second;
}

function repeat(count, string) {
  var result = "";
  for (var i = 0; i < count; i++) {
    result += string;
  }

  return result;
}

function partial(primary, arg1) {
  return function(arg2) {
    return primary(arg1, arg2);
  };
}
```
```bash
> var add1 = partial(add, 1);
> add1(2);
= 3
> add1(6);
= 7
> var threeTime = partial(repeat, 3);
> threeTimes("Hello");
HelloHelloHello
> threeTimes("!");
!!!
```

Closures are similar to objects. They can organize code into data and behavior that relies on that data.

### Problems
1. Write a function named `greet` that takes two arguments and logs a greeting.
```javascript
function greet(greeting, name) {
  var capitalized = greeting[0].toUpperCase() + greeting.slice(1);
  var message = capitalized + ", " + name + "!";
  console.log(message);
}
```

2. Use the `partial` function shown above and your solution to problem 1 to create `sayHello` and `sayHi` functions that work like this:
```bash
> sayHello("Brandon");
Hello, Brandon!
> sayHi("Sarah");
Hi, Sarah!
```

```javascript
var sayHello = partial(greet, "Hello");
var sayHi = partial(greet, "Hi");
```

## Practice Problems: Partial Function Application

1. Implement `sub5` below such that the invocation on the last line return `5`.
```javascript
function subtract(a, b) {
  return a - b;
}

function sub5(a) {
  return subtract(a, 5);
}

sub5(10);
```

2. This code is a bit limited however, because we can only subtract by 5. Implement the `makeSubN` function below so that we can supply any value we want to be subtracted from `a`, and get a new function that will always subtract this value.
```javascript
function subtract(a, b) {
  return a - b;
}

function makeSubN(n) {
  return function(a) {
    return subtract(a, n);
  }
}

var sub5 = makeSubN(5);
sub5(10); // 5
```

3. Although the solution above is more flexible, we now want to be able to supply any operation, not just subtraction. Implement `makeParticalFunc` below.
```javascript
function makePartialFunc(func, b) {
  return function(a) {
    return func(a, b);
  };
}

function multiply(a, b) {
  return a * b;
}

var multiplyBy5 = makePartialFunc(function(a, b) {
  return a * b;
}, 5);

multiplyBy5(100); // 500
```

4. In our previous solution, `multiplyBy5` retains access to `func` and `b` long after `makePartialFunc` has finished execution. What makes this possible?
Answer: closure. The newly created function (`multiplyBy5`) retains access to all of the references visible to it at the moment and in the lexical location of its creation.

5. Consider the code below:
Implement `makeMathRollCall` such that it returns a partially applied `rollCall` function, with the subject as `"Math"`.
```javascript
var subjects = {
  "English": ["Bob", "Tyrone", "Lizzy"],
  "Math": ["Fatima", "Gary", "Susan"],
  "Biology": ["Jack", "Sarah", "Tanya"]
};

function rollCall(subject, students) {
  console.log(subject + ':');
  students.forEach(function(student) {
    console.log(student);
  });
}

function makeMathRollCall() {
  return function(students) {
    rollCall("Math", students);
  }
}

var mathRollCall = makeMathRollCall();
mathRollCall(subjects["Math"]);
// Math:
// Fatima
// Gary
// Susan
```

## Immediately Invoked Function Expressions

An **immediately invoked function expression (IIFE)** is a function that is defined and invoked simultaneously.
```javascript
(function() {
  console.log('hello');
})();                   // hello
```

Invoking parentheses can be inside as well.
```javascript
(function() {
  console.log('hello');
}());                   // hello
```

The IIFE parentheses can be omitted when the function declaration is an expression that doesn't occur at the beginning of a line.
```javascript
var foo = function() {
  return function() {
    return 10;
  }();
}();

console.log(foo);       // 10
```

## Creating a Private Scope with an IIFE
```javascript
// thousands of lines of messy JavaScript code!

for (var i = 0; i < 100; i++) {
  console.log(i);
}

// more messy JavaScript code
```
What's the problem here? Answer: we don't know if `i`is already in the global scope. If it is, then this code will alter its value and may cause trouble.

Since functions create their own scope, put this in a function.
```javascript
// thousands of lines of messy JavaScript code!

function loopAndLog() {
  for (var i = 0; i < 100; i++) {
    console.log(i);
  }
}

loopAndLog();

// more messy JavaScript code
```
This isolates `i` but still has a subtle problem. What if `loopAndLog` is already defined. Remember functions are variables too and this declaration could overwrite the original function.

IIFE can solve this.
```javascript
// thousands of lines of messy JavaScript code!

(function() {
  for (var i = 0; i < 100; i++) {
    console.log(i);
  }
})();

// more messy JavaScript code
```
The IIFE has a private scope for `i` and it won't clash with other functions.

With an argument
```javascript
// thousands of lines of messy JavaScript code!

(function(number) {
  for (var i = 0; i < number; i++) {
    console.log(i);
  }
})(100);

// more messy JavaScript code
```

> The IIFE pattern provides a way to create a "module" of sorts.

## Practice Problems: IIFEs

1. Will the code below execute?
```javascript
function() {
  console.log("Sometimes, syntax isn't intuitive!")
}();
```

Solution
```
Uncaught SyntaxError: Unexpected token (
```

2. Edit the code from problem one such that it executes without error.

Solution
```javascript
(function() {
  console.log("Sometimes, syntax isn't intuitive!");
})();
```

3. The code below throws an error:
```javascript
var sum = 0;

sum += 10;
sum += 31;

var numbers = [1, 7, -3, 3];

function sum(arr) {
  return arr.reduce(function(sum, number) {
    sum += number;
    return sum;
  }, 0);
}

sum += sum(numbers); // ?
```

What kind of problem does this error highlight? Use an IIFE to address it, so that code runs without error.

Solution
This is a name conflict. On the last line `sum(numbers)` is trying to invoke the function `sum` but because of hoisting, `sum` is the variable referencing the primitive value of `41`. This is a `TypeError`.
```javascript
var sum = 0;

sum += 10;
sum += 31;

var numbers = [1, 7, -3, 3];

sum += (function(arr) {
  return arr.reduce(function(sum, number) {
    sum += number;
    return sum;
  }, 0);
})(numbers);
```

4. Consider the output below:
```
countdown(7);
7
6
5
4
3
2
1
0
Done!
```
Implement a function countdown that uses an IIFE to generate the desired output.
```javascript
function countdown(count) {
  (function(n) {
    for (var i = n; i >= 0; i--) {
      console.log(n);
    }
    console.log("Done!");
  })(count);
}
```

5. Will the named function inside of this IIFE be accessible in the global scope?
```javascript
(function foo() {
  console.log("Bar");
})();

foo() // ?
```

Solution
No. Even though it is named, it is not visible outside of the scope created by the IIFE.

6. For an extra challenge, refactor the solution to problem 4 using recursion, bearing in mind that a named function created in an IIFE can be referenced inside of the IIFE.

Solution
```javascript
function countdown(count) {
  (function recursive(n) {
    console.log(n);

    if (n === 0) {
      console.log("Done!");
    } else {
      recursive(n - 1);
    }
  })(count);
}
```

## Summary

> * Closures let a function access any variable that was in scope when the function was declared.
> * Values that are no longer accessible from anywhere in the code are eligible for **garbage collection**, which frees up the memory that they used for reuse by other parts of the program.
> * You can use closures to make variables "private" to a function or set of functions and inaccessible elsewhere.
> * Closures allow functions to "carry around" values for later use.
> * **Higher-order functions** are functions that take a function as an argument, return a function, or both.
