# Function Contexts and Objects

<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Function Contexts and Objects](#function-contexts-and-objects)
  * [The Global Object](#the-global-object)
    * [Global Object as Implicit Context](#global-object-as-implicit-context)
    * [Global Variables and Function Declarations](#global-variables-and-function-declarations)
    * [Note](#note)
  * [Practice Problems: The Global Object](#practice-problems-the-global-object)
  * [Implicit and Explicit Function Execution Contexts](#implicit-and-explicit-function-execution-contexts)
    * [Function Execution Context](#function-execution-context)
    * [Implicit Function Execution Context](#implicit-function-execution-context)
      * [Implicit Method Execution Context](#implicit-method-execution-context)
    * [Explicit Function Execution Context](#explicit-function-execution-context)
    * [Practice Problems: Implicit and Explicit Function Execution Contexts](#practice-problems-implicit-and-explicit-function-execution-contexts)
  * [Hard Binding Functions with Contexts](#hard-binding-functions-with-contexts)
  * [Practice Problems: Hard Binding Functions with Contexts](#practice-problems-hard-binding-functions-with-contexts)
  * [Dealing with Context Loss (1)](#dealing-with-context-loss-1)
    * [Method Losing Context when Taken Out of Object](#method-losing-context-when-taken-out-of-object)
  * [Dealing with Context Loss (2)](#dealing-with-context-loss-2)
    * [Internal Function Losing Method Context](#internal-function-losing-method-context)
      * [Solution 1: Preserve Context with a Local Variables in the Lexical Scope](#solution-1-preserve-context-with-a-local-variables-in-the-lexical-scope)
      * [Solution 2: Pass the Context to Internal Functions](#solution-2-pass-the-context-to-internal-functions)
      * [Solution 3: Bind the Context with a Function Expression](#solution-3-bind-the-context-with-a-function-expression)
  * [Dealing with Context Loss (3)](#dealing-with-context-loss-3)
    * [Function as Argument Losing Surrounding Context](#function-as-argument-losing-surrounding-context)
      * [Solution 1: Use a local varaible in the lexical scope to store this](#solution-1-use-a-local-varaible-in-the-lexical-scope-to-store-this)
      * [Solution 2: Bind the argument function with the surrounding context](#solution-2-bind-the-argument-function-with-the-surrounding-context)
      * [Solution 3: Use the optional thisArg argument](#solution-3-use-the-optional-thisarg-argument)
  * [Practice Problems: Dealing with Context Loss](#practice-problems-dealing-with-context-loss)
  * [Summary: The "this" Keyword in JavaScript](#summary-the-this-keyword-in-javascript)
  * [Practice Problems: What is this? (1)](#practice-problems-what-is-this-1)
  * [Practice Problems: What is this? (2)](#practice-problems-what-is-this-2)
  * [Summary](#summary)

<!-- tocstop -->
## The Global Object
JS creates a **global object** when it starts running. In the browser, the global object is the `window` object.

*Global values* list `Infinity` and `NaN` and *global functions* are all properties of the global object.

```javascript
window.isNaN;     // function isNaN() { ... }
window.Infinity;  // Infinity
```

### Global Object as Implicit Context
The global object is the implicit context when we evaluate expressions.
```javascript
foo = 1;
foo;      // 1
```


### Global Variables and Function Declarations
When they are defined, JS add them to the global object.
```javascript
var moreFoo = 3;

function bar() {
  return 1;
}

window.moreFoo;     // 3
window.bar;         // function bar() { return 1; }
```
```javascript
function bar () {         // variable defined
  return 1;
}

var moreFoo = 3;          // variable defined
moreBar = 2;              // variable not defined

delete window.bar;        // false (not deleted)
delete window.moreFoo;    // false (not deleted)
delete window.moreBar;    // true (deleted)

window.bar();             // 1
window.moreFoo;           // 3
window.moreBar;           // undefined
```

### Note
Non-browser environments may have a different global object instead of `window`. In Node, `global` is the global object.

## Practice Problems: The Global Object
1. In a browser environment, what is meant by implicit execution context?
    This is the global object. In the browser this is `window`.
2. What does the code below output?
    ```javascript
    a = 10;

    console.log(window.a === a);
    ```
    `true`. Initializing an undeclared variable automatically creates a property on the global object, `window`.
3. What does the code below output?
    ```javascript
    function func() {
      var b = 1;
    }

    func();

    console.log(b);
    ```
    `Uncaught ReferenceError: b is not defined`. `b` is not a property on the global object.
4. What does the code below output?
    ```javascript
    function func() {
      b = 1;
    }

    func();

    console.log(b);
    ```
    `1`. `b` is not declared, just initialized. So `b` is created as a property on the global object even though it is initialized in function scope.
5. Of the variables a, b, and c below, can any be successfully deleted?
    ```javascript
    var a = 1;

    delete a; // => ?
    delete b; // => ?
    delete c; // => ?
    ```
    `b` can be deleted because it was not declared, only initialized. You can only deleted *undeclared* global variables, not *declared* global variables.
6. In the code below, will we be able to delete func?
    ```javascript
    function func() {
    }

    delete func; // => ?
    ```
    No. `func` is declared.
7. Of the variables a, b, and c below, can any be deleted?
    ```javascript
    window.a = 1;
    b = 2;
    var c = b;

    delete window.a; // => ?
    delete window.b; // => ?
    delete window.c; // => ?
    ```
    `a` and `b` can be deleted. Even though `a` is added explicitly to the global object, it is not being declared using `var`, so it can be deleted just like undeclared variables.

## Implicit and Explicit Function Execution Contexts
### Function Execution Context
A function invoked has access to an object called the **execution context** on that function invocation. This is accessed through the keyword `this`. So `this` changes depending on how the function was invoked.
NOTE: The binding of `this` **does not follow** lexical scoping rules.
### Implicit Function Execution Context
(Also called implicit binding for functions) is the context for a function when it is invoked without explicit context. These functions are binded to the global object.
```javascript
function foo() {
}

foo();          // "this here is: [object Window]"
```
**When you execute a function, not when you define it** is where the binding occurs.
```javascript
var object = {
  foo: function() {
  }
};

object.foo();              // "this here is: [object Object]"

bar = object.foo;
bar();                     // "this here is: [object Window]"
```

#### Implicit Method Execution Context
Binding for `this` is the owning object:
```javascript
var foo = {
  bar: function() {
  	return this;
  }
}

foo.bar() === foo; // true
```
**NOTE:** Again, know that implicit execution context is bound upon *invocation*, not upon *declaration*.

### Explicit Function Execution Context
```javascript
var a = 1;

var object = {
};

function foo() {
  return this.a;
}

foo();              // 1 (context is global object)
```

In this way a method can be "borrowed".
```javascript
var strings = {
  foo: function() {
    return this.a + this.b;
  }
};

var numbers = {
  a: 1,
  b: 2
};

strings.foo.call(numbers);      // 3
```
This is like the object `numbers` is borrowing the method `foo` from the object `strings`. Note that `foo` is **not** being copied.

Arguments can be passed to `call` as so.
```javascript
someObject.someMethod.call(context, arg1, arg2, arg3[, ...])
```

Example
```javascript
var iPad   = {
  price: 40000
};
var kindle = {
  price: 30000
};

function printLine(lineNumber, punctuation) {
  console.log(lineNumber + ': ' + this.name + ', ' + this.price / 100 + ' dollars' + punctuation);
}

printLine.call(iPad, 1, ';');        // "1: iPad, 400 dollars;"
printLine.call(kindle, 2, '.');      // "2: kindle, 300 dollars."
```

`apply` is identical to `call` expect that `apply` takes arguments as an Array.

```javascript
someObject.someMethod.apply(context, [arg1, arg2, arg3..])
```

> * **C** all: **C** ount the **C** ommas (you have to count the number of arguments to match the called function)
> * **A** pply: **A** rguments as **A** rray

### Practice Problems: Implicit and Explicit Function Execution Contexts

1. What will the code below output?
    ```javascript
    function func() {
      return this;
    }

    var context = func();

    console.log(context);
    ```
    Solution
    `[object Window]`

2. What will the code below output? Explain the difference, if any, between this output and that of problem 1.
    ```javascript
    var o = {
      func: function() {
        return this;
      }
    };

    var context = o.func();

    console.log(context);
    ```
    Solution
    ```
    Object {func: function}
    ```

3. What will the code below output?
    ```javascript
    var message = 'Hello from the global scope!';

    function deliverMessage() {
      console.log(this.message);
    }

    deliverMessage();

    var foo = {
      message: "Hello from the function scope!"
    };

    foo.deliverMessage = deliverMessage;

    foo.deliverMessage();
    ```
    Solution
    ```
    Hello from the global scope!
    Hello from the function scope!
    ```

4. What will the code below output?
    ```javascript
    var a = 10;
    var b = 10;
    var c = {
      a: -10,
      b: -10
    };
    function add() {
      return this.a + b;
    }

    c.add = add;

    console.log(add());
    console.log(c.add());
    ```
    Solution
    ```
    20
    0
    ```

5. The problems above all feature implicit function execution context. What methods have we learned so far that allow us to explicitly specify what a function's execution context should be?

  Solution
  The `Function` methods `call` and `apply`, which are essentially the same except `apply` takes arguments as an array.


6. In the code below, use `call` to invoke `add` as a method on `bar` but with `foo` as execution context. What will this return?
    ```javascript
    var foo = {
      a: 1,
      b: 2
    };

    var bar = {
       a: "abc",
       b: "def",
       add: function() {
         return this.a + this.b;
       }
    };
    ```
    Solution
    ```javascript
    bar.add.call(foo);  // => 3
    ```

7. Given the code and desired output below, would it make more sense to use call or apply to supply explicit context and arguments to outputList? Implement a solution using one of the methods, such that the desired output is logged, and explain your choice.

    ```javascript
    var fruitsObj = {
      list: ['Apple', 'Banana', 'Grapefruit', 'Pineapple', 'Orange'],
      title: "A Collection of Fruit"
    }


    function outputList() {

      var args = [].slice.call(arguments);

      args.forEach(function(elem) {
        console.log(elem);
      });
    }

    // invoke outputList here
    ```

    Desired output:
    ```
    A Collection of Fruit:
    Apple
    Banana
    Grapefruit
    Pineapple
    Orange
    ```
    Solution
    ```javascript
    outputList.apply(fruitsObj, fruitsObj.list);
    ```

8. For an extra challenge, consider this line of code from the previous problem:
    ```javascript
    var args = [].slice.call(arguments);
    ```
    Inside of JavaScript functions, arguments is an object that holds all of the arguments passed to the function. Bearing in mind that the function author wants to iterate over the arguments later in the method using an Array method, why do you think he or she is invoking call?
    Solution

## Hard Binding Functions with Contexts
`bind` lets us bind a function to a context object permanently
```javascript

var object = {
  foo: function() {
  }
};

var bar = object.foo;

var baz = object.foo.bind(object);

var object2 = {
};

```


JavaScript implements `bind` something like this:
```javascript
Function.prototype.bind = function () {
  var fn = this;
  var args = Array.prototype.slice.call(arguments);
  var context = args.shift;

  return function () {
    fn.apply(context, args.concat(Array.prototype.slice.call(arguments)));
  };
}
```

## Practice Problems: Hard Binding Functions with Contexts

1. What function can we use to permanently bind a function to a particular execution context?

Solution
    `bind`

2. What will the code below log to console?
```javascript
var obj = {
  message: "JavaScript"
}

function foo() {
  console.log(this.message);
}

foo.bind(obj);
```
Solution
Nothing. `bind` returns a *new function* permanently bound to the context argument.

3. What will the code below output?
```javascript
var a = 1;
var b = -1;
var obj = {
  a: 2,
  b: 3
};

function foo() {
  return this.a + this.b;
}

var bar = foo.bind(obj);

console.log(foo());
console.log(bar());
```
Solution
```
0
5
```

4. What will the code below log to the console?
```javascript
var positiveMentality = {
  message: "JavaScript makes sense!"
};

var negativeMentality = {
  message: "JavaScript makes no sense!"
};

function foo() {
  console.log(this.message);
}

var bar = foo.bind(positiveMentality);

negativeMentality.logMessage = bar;
negativeMentality.logMessage();
```
Solution
```
JavaScript makes sense!
```

5. What will the code below output?
```javascript

function foo() {
  console.log(this.a);
}

var bar = foo.bind(obj);

bar.call(otherObj);
```
Solution
```
```

## Dealing with Context Loss (1)

### Method Losing Context when Taken Out of Object
```javascript
var john = {
  greetings: function() {
  }
};

var foo = john.greetings; // Strips context
foo();

// "hello, undefined undefined"
```
Can use `foo.call(john)` to restore context but in reality, `john` may be out of scope when `foo` is ready to be called.
```javascript
function repeatThreeTimes(func) {
  func();
  func();
}

function foo() {
  var john = {
    greetings: function() {
    }
  };

  repeatThreeTimes(john.greetings); // Strips context
}

foo();

// "hello, undefined undefined"
// "hello, undefined undefined"
// "hello, undefined undefined"
```
If you have the ability to alter `repeatThreeTimes` then add a parameter to pass in the context.
```javascript
function repeatThreeTimes(func, context) {
  func.call(context);
  func.call(context);
  func.call(context);
}

function foo() {
  var john = {
    greetings: function() {
    }
  };

  repeatThreeTimes(john.greetings, john);
}

foo();

// "hello, John Doe"
// "hello, John Doe"
// "hello, John Doe"
```
```javascript
function repeatThreeTimes(func) {
  func();
  func();
  func();
}

function foo() {
  var john = {
    greetings: function() {
    }
  };

  repeatThreeTimes(john.greetings.bind(john));
}

foo();

// "hello, John Doe"
// "hello, John Doe"
// "hello, John Doe"
```

## Dealing with Context Loss (2)

### Internal Function Losing Method Context
```javascript
obj = {
  foo: function() {
    function bar() {
    }

    bar();
  }
};

obj.foo();        // undefined undefined
```
Since `bar()` on line 9 does not provide an explicit context, JavaScript binds the global object to the function. So `this` on line 6 is the global object, not `obj`.

#### Solution 1: Preserve Context with a Local Variables in the Lexical Scope
Do `var self = this` or `var that = this`. `this` si then saved in a variable name `self` or `that` before calling the function, then reference the variable in the function.
```javascript
obj = {
  foo: function() {
    var self = this;

    function bar() {
    }
    bar();
  }
};

obj.foo();        // hello world
```
So now, based on lexical scoping rules, `bar` has access to `self`.

#### Solution 2: Pass the Context to Internal Functions
```javascript
obj = {
  foo: function() {
    function bar() {
    }

    bar.call(this);
  }
};

obj.foo();        // hello world
```

#### Solution 3: Bind the Context with a Function Expression
Use `bind` when the function is defined to make the context permanently `bar`. Note `bind` must be called with a function expression, not a function declaration.
```javascript
obj = {
  foo: function() {
    var bar = function() {
    }.bind(this);

    // some lines of code

    bar();

    // more lines of code

    bar();

    // ...
  }
};

obj.foo();        // hello world
```
The benefit is that `bind` needs to be used only once, then it can be called without explicitly providing context.

## Dealing with Context Loss (3)

### Function as Argument Losing Surrounding Context
```javascript
function repeatThreeTimes(func) {
  func();
  func();
  func();
}

var john = {
  greetings: function() {
    repeatThreeTimes(function() {
    });
  }
};

john.greetings();

// "hello, undefined undefined"
// "hello, undefined undefined"
// "hello, undefined undefined"
```
Another example
```javascript
obj = {
  foo: function() {
    [1, 2, 3].forEach(function(number) {
    });
  }
};

obj.foo();

// 1 undefined undefined
// 2 undefined undefined
// 3 undefined undefined
```

#### Solution 1: Use a local varaible in the lexical scope to store this
```javascript
obj = {
  foo: function() {
    var self = this;
    [1, 2, 3].forEach(function(number) {
    });
  }
};

obj.foo();

// 1 hello world
// 2 hello world
// 3 hello world
```

#### Solution 2: Bind the argument function with the surrounding context
```javascript
obj = {
  foo: function() {
    [1, 2, 3].forEach(function(number) {
    }.bind(this));
  }
};

obj.foo();

// 1 hello world
// 2 hello world
// 3 hello world
```

#### Solution 3: Use the optional thisArg argument

Some methods that take function arguments allow an optional argument that defines the context to use when executing the function. `Array.protoetype.forEach`, for instance, has an optional `thisArg` argument for the context. This argument makes it easy to work around this context loss problem.
```javascript
obj = {
  foo: function() {
    [1, 2, 3].forEach(function(number) {
    }, this);
  }
};

obj.foo();

// 1 hello world
// 2 hello world
// 3 hello world
```

`Array.prototype.map`, `Array.prototype.every`, and `Array.prototype.some` also provide an optional `thisArg` argument.

## Practice Problems: Dealing with Context Loss
1. Our desired output for the code below is: Christopher Turk is a Surgeon. What will the code output, and what explains the difference, if any, between the actual and desired outputs?

```javascript
var turk = {
  first_name: "Christopher",
  last_name: "Turk",
  occupation: "Surgeon",
  getDescription: function() {
  }
};

function logReturnVal(func) {
  var returnVal = func();
  console.log(returnVal);
}

logReturnVal(turk.getDescription);
```
Solution

* The value of `this` when `logReturnVal` is invoked is the global object. There is no `first_name`, `last_name`, or `occupation` properties of the global object so the output with be `undefined undefined is a undefined`.
* `getDescription` was removed from its context of `turk` and passed into `logReturnVal`.

---


Solution
  ```javascript
  function logReturnVal(func, context) {
    var returnVal = func.call(context);
    console.log(returnVal);
  }
  ```


Solution
  ```javascript
  var getTurkDescription = turk.getDescription.bind(turk);
  ```

4. Consider the code below, and our desired output:
```javascript
var TESgames = {
  seriesTitle: "The Elder Scrolls",
  listGames: function() {
    this.titles.forEach(function(title) {
    });
  }
}

TESgames.listGames();
```
Desired output:
```
The Elder Scrolls Arena
The Elder Scrolls Daggerfall
The Elder Scrolls Morrowind
The Elder Scrolls Oblivion
The Elder Scrolls Skyrim
```
Will this code log our desired output? Why or why not?

Solution
* This will not log the desired output because `this` on line 5 and 6 is the global object because the anonymous function passed into `forEach` does not have explicit context. Inner functionsn in objects lose that object as context.

5. Use the var self = this fix (introduced in Dealing with Context Loss (2)) to alter TESgames.listGames such that it logs our desired output to the console.

Solution

```javascript
var TESgames = {
  seriesTitle: "The Elder Scrolls",
  listGames: function() {
    var self = this;
    this.titles.forEach(function(title) {
    });
  }
}
```


Solution

```javascript
var TESgames = {
  seriesTitle: "The Elder Scrolls",
  listGames: function() {
    this.titles.forEach(function(title) {
    }, this);
  }
}
```

7. Consider the code below:

```javascript
var foo = {
  a: 0,
  incrementA: function() {
    function increment() {
      this.a += 1;
    }

    increment();
  }
}

foo.incrementA();
foo.incrementA();
foo.incrementA();
```
What will the value of foo.a be after this code has executed?

Solution
`0`
* Inner functions lose the outer object as context. `this` is the global object, not `foo`. So `foo.a` remains unchanged.

8. Use one of the methods we learned in this lesson to invoke increment with explicit context such that foo.a is incremented with each invocation of incrementA.

Solution
```javascript
var foo = {
  a: 0,
  incrementA: function() {
    function increment() {
      this.a += 1;
    }

    increment.apply(this);
  }
}

foo.incrementA();
foo.incrementA();
foo.incrementA();
```

9. We decide that we want each invocation of foo.incrementA to increment foo.a by 3, rather than 1, and alter our code accordingly:

```javascript
var foo = {
  a: 0,
  incrementA: function() {
    function increment() {
      this.a += 1;
    }

    increment.apply(this);
    increment.apply(this);
    increment.apply(this);
  }
}
```

Solution
```javascript
var foo = {
  a: 0,
  incrementA: function() {
    var increment = function() {
      this.a += 1;
    }.bind(this);

    increment(this);
    increment(this);
    increment(this);
  }
}
```

## Summary: The "this" Keyword in JavaScript

>
>

## Practice Problems: What is this? (1)
While working through these practice problems, assume that the code runs within a web page.

1. What does `this` point to in the code below?
```javascript
function whatIsMyContext() {
  return this;
}
```
Solution
The context of a function is not known until execution time, not definition time.

---

2. What does `this` point to in the code below?
```javascript
function whatIsMyContext() {
  return this;
}

whatIsMyContext();
```
Solution
```
Window
```
Function calls set execution context to the *implicit global object*, which on a webpage is `window`.

---

3. What does `this` point to in the code below?
```javascript
function foo() {
  function bar() {
    function baz() {
      console.log(this);
    }
    baz();
  }
  bar();
}

foo();
```
Solution
`baz` is called with the implicit global context (no explicit receiver), so `this` is `window`.

---

4. What does `this` point to in the code below?
```javascript
var obj = {
  count: 2,
  method: function() {
    return this.count;
  }
};

obj.method();
```
Solution
`2`. Method invocation means that `this` points to the explicit receiver, the object that contains that method.

---

5. What does the following program log to the console?
```javascript
function foo() {
  console.log(this.a);
}

var a = 2;
foo();
```
Solution
`2`. `foo` is called with the global context so `this` is `window`. `var a = 2` defines `a` on `window`.

---

6. What does the following program log to the console?
```javascript
var a = 1;

function bar() {
  console.log(this.a);
}

var obj = {
  a: 2,
  foo: bar
};

obj.foo();
```
Solution
`2`. This is method invocation so `this` is `obj` when `foo` is called. Since `foo` calls `bar`, `bar` will now have `obj` as the context.

---

7. What does the following code log to the console?
```javascript
foo = {
  a: 1,
  bar: function() {
    console.log(this.baz());
  },
  baz: function() {
    return this;
  }
};

foo.bar();
var qux = foo.bar;
qux();
```
Solution
```
Object {a: 1}
Uncaught TypeError: this.baz is not a function(...)
```
`foo.bar()` is a method invocation so the context of `bar` is `foo`. `bar` uses method invocation `this.baz()`. Since `this` is `foo` it is the same as saying `foo.baz()`. Now inside `baz`, `this` is still `foo` which is logged to the console.

The next output uses function invocation which means `this` is set to the implicit global context, `window`. Because `window` does not have a function `baz`, an error is thrown.

## Practice Problems: What is this? (2)
While working through these practice problems, assume that the code runs within a web page.

1. What does `this` point to in the code below, and what does it return?
```javascript
var myObject = {
  count: 1,
  myChildObject: {
    myMethod: function() {
      return this.count;
    }
  }
};

myObject.myChildObject.myMethod();
```
Solution
`this` points to the object `myChildObject` and it returns `undefined`.

---

2. In the previous problem, how would you change the context, or the value of this, to be the parent myObject?
Solution
Use `call` or `apply`
```
myObject.myChildObject.mymethod.call(myOjbect);
```

---

3. What does the following code log to the console?
```javascript
var person = {
  firstName: "Peter",
  lastName: "Parker",
  fullName: function() {
    console.log(this.firstName + " " + this.lastName +
                " is the Amazing Spiderman!");
  }
};

var whoIsSpiderman = person.fullName.bind(person);
whoIsSpiderman();
```
Solution
```
Peter Parker is the Amazing Spiderman!
```
`bind` permantently binds `this` in `fullName` to `person`.

---

4. What does the following code log to the console?
```javascript
var a = 1;
var obj = {
  a: 2,
  func: function() {
    console.log(this.a);
  }
};

obj.func();
obj.func.call();
obj.func.call(this);
obj.func(obj);

var obj2 = { a: 3 };
obj.func.call(obj2);
```
Solution
```
2   // this is obj
1   // this is the global object
1   // this is the global object
2   // this is obj. The obj in the argument of func is ignored
3   // this is obj2, the context of func was changed by call.
```

---

5. What does the following code log to the console?
```javascript
var computer = {
  price: 30000,
  shipping: 2000,
  total: function() {
    var tax = 3000;
    function specialDiscount() {
      if (this.price > 20000) {
        return 1000;
      } else {
        return 0;
      }
    }

    return this.price + this.shipping + this.tax - specialDiscount();
  }
};

console.log(computer.total());
```
If you want this program to log 34000, how would you fix it?

Solution
`this.tax` is `undefined` since `this` is the object `computer` which does not have a `tax` property. This code will log `NaN`.

To fix this, save `this` as `self` in lexical scope:
```javascript
var computer = {
  price: 30000,
  shipping: 2000,
  total: function() {
    var tax = 3000;
    var self = this;
    function specialDiscount() {
      if (self.price > 20000) {
        return 1000;
      } else {
        return 0;
      }
    }

    return this.price + this.shipping + tax - specialDiscount();
  }
};

console.log(computer.total());
```

Or `bind` `this` from `total` to `specialDiscount`
```javascript
var computer = {
  price: 30000,
  shipping: 2000,
  total: function() {
    var tax = 3000;
    var specialDiscount = function() {
      if (this.price > 20000) {
        return 1000;
      } else {
        return 0;
      }
    }.bind(this)

    return this.price + this.shipping + tax - specialDiscount();
  }
};

console.log(computer.total());
```

Or use `call` or `apply` to invoke `specialDiscount`
```javascript
var computer = {
  price: 30000,
  shipping: 2000,
  total: function() {
    var tax = 3000;
    var specialDiscount = function() {
      if (this.price > 20000) {
        return 1000;
      } else {
        return 0;
      }
    }

    return this.price + this.shipping + tax - specialDiscount.call(this);
  }
};

console.log(computer.total());
```

## Summary
> * Function invocations, e.g., `parseInt(numberString)` rely upon implicit execution context that resolves to the global object. Method invocations, e.g., `array.forEach(processElement)` rely upon implicit context that resolves to the object that holds the method.
>
> * All JavaScript code executes within a context. The top level context in a web browser is the `window` object. All global methods and Objects (such as `isNaN` or `Math`) are properties of this object.
>
>
```javascript
var car = 1;
function speak() { ... }
```
>
> * `this` is the current execution context of a function.
>
> * The value of `this` changes based on **how you invoke a function**, not **how you define it**.
>
> * JavaScript has **first-class functions** which have the following characteristics:
>
>   * You can add them to objects and execute them in their contexts.
>   * You can remove them from their objects, pass them around, and execute them in entirely different contexts.
>
> * `call` and `apply` invoke a function with an explicit execution context.
>
> * `bind` permanently binds a Function to the context of an object.
>
> * A function included in an object that can operate on data within that object is a **method**.
