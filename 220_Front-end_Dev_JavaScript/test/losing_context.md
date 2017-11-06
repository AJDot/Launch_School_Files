
<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Losing Context](#losing-context)
  * [Method Losing Context when Taken Out of Object](#method-losing-context-when-taken-out-of-object)
  * [Internal Function Losing Method Context](#internal-function-losing-method-context)
  * [Function as Argument Losing Surrounding Context](#function-as-argument-losing-surrounding-context)

<!-- tocstop -->
# Losing Context
## Method Losing Context when Taken Out of Object
```javascript
// when bar.alpha and bar.numeric are passed into func1plusFunc2
// the execution context for this inside those functions becomes
// func1PlusFunc2 which does not have a `text` property.
function func1PlusFunc2(func1, func2) {
  return func1() + func2();
}

function foo() {
  var bar = {
    text: '1a2b3c',
    alpha: function() {
      return this.text.match(/[a-z]/gi).join('');
    },
    numeric: function() {
      return this.text.match(/[0-9]/g).join('');
    },
  }

  func1PlusFunc2(bar.alpha, bar.numeric);
}

foo(); // Uncaught TypeError: Cannot read property 'match' of undefined
```
THE FIX
```javascript
// Bind bar.alpha and bar.numeric to the object bar
function func1PlusFunc2(func1, func2) {
  return func1() + func2();
}

function foo() {
  var bar = {
    text: '1a2b3c',
    alpha: function() {
      return this.text.match(/[a-z]/gi).join('');
    },
    numeric: function() {
      return this.text.match(/[0-9]/g).join('');
    },
  }

  console.log(func1PlusFunc2(bar.alpha.bind(bar), bar.numeric.bind(bar)));
}

foo(); // "abc123"
```

## Internal Function Losing Method Context
```javascript
obj = {
  firstName: "Alex",
  lastName: "Henegar",
  age: 29,
  occupation: "none",
  info: function() {
    function fullName() {
      return this.firstName + ' ' + this.lastName;
    }

    return {
      name: fullName(),
      age: this.age,
      occupation: this.occupation,
    }
  }
}

console.log(obj.info()); // {name: "undefined undefined", age: 29, occupation: "none"}
// `fullName` is not executed with explict context so JavaScript binds it
// to the global object. So `this` is not `obj`, it's the global object
// which does not have a `firstName` or `lastName` property.
```
THE FIXES
```javascript
// Preserve Context with a Local Variable in Lexical Scope
obj = {
  firstName: "Alex",
  lastName: "Henegar",
  age: 29,
  occupation: "none",
  info: function() {
    var self = this;
    function fullName() {
      return self.firstName + ' ' + self.lastName;
    }

    return {
      name: fullName(),
      age: this.age,
      occupation: this.occupation,
    }
  }
}

console.log(obj.info()); // {name: "Alex Henegar", age: 29, occupation: "none"}
```
```javascript
// Call inner function on the obj explicitly
obj = {
  firstName: "Alex",
  lastName: "Henegar",
  age: 29,
  occupation: "none",
  info: function() {
    function fullName() {
      return this.firstName + ' ' + this.lastName;
    }

    return {
      name: fullName.call(obj),
      age: this.age,
      occupation: this.occupation,
    }
  }
}

console.log(obj.info()); // {name: "Alex Henegar", age: 29, occupation: "none"}
```
```javascript
// Bind function to object
// Must use function expression, NOT a function declaration
obj = {
  firstName: "Alex",
  lastName: "Henegar",
  age: 29,
  occupation: "none",
  info: function() {
    var fullName = function() {
      return this.firstName + ' ' + this.lastName;
    }.bind(obj);

    return {
      name: fullName(),
      age: this.age,
      occupation: this.occupation,
    }
  }
}

console.log(obj.info()); // {name: "Alex Henegar", age: 29, occupation: "none"}
```

## Function as Argument Losing Surrounding Context
```javascript
// the anonymous function passed to `forEach` gets executed without explicit
// context, meaning the execution context is the global object which does not
// have a `firstName` or `lastName` property.
obj = {
  firstName: "Alex",
  lastName: "Henegar",
  age: 29,
  occupation: "none",
  info: function() {
    [1, 2, 3, 4].forEach(function(number) {
      console.log(String(number) + ' ' + this.firstName + ' ' + this.lastName);
    });
  }
}

obj.info();

// 1 undefined undefined
// 2 undefined undefined
// 3 undefined undefined
// 4 undefined undefined
```
THE FIX
```javascript
// Any of the methods for the previous problem
obj = {
  firstName: "Alex",
  lastName: "Henegar",
  age: 29,
  occupation: "none",
  info: function() {
    var self = this;
    [1, 2, 3, 4].forEach(function(number) {
      console.log(String(number) + ' ' + self.firstName + ' ' + self.lastName);
    });
  }
}

obj.info();

// 1 Alex Henegar
// 2 Alex Henegar
// 3 Alex Henegar
// 4 Alex Henegar
```
