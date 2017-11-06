# `this` 2
```javascript
function func5(func) {
  func();
}

var o = {
  func1: function() {
    return this;
  },
  func2: function() {
    return (function() {
      return this;
    })();
  }
}

var o2 = {
  func3: function() {
    function a() {
      return this;
    }
    return a();
  },
  func4: function() {
    console.log("Inside func4: ", this);
    func5(function() {
      console.log("Inside func5: ", this);
    });
    (function() {
      console.log("Inside IIFE inside func4: ", this)
    })();
  }
};

// Implicit method invocation
// binding is the owning object [object o]
console.log("o.func1()::", o.func1()); // returns the object o

// Implicit function invocation
// change context by invoking method with function invocation in global object
// func1 loses o as context because it was invoked outside of the object
var foo = o.func1;
console.log("foo()::", foo()); // returns the object Window

// Internal function loses context
// The IIFE inside func2 is called without explicit context which means
// it is invoked with the global object (Window) as context.
// this is [object Window]
console.log("o.func2()::", o.func2()); // returns the object Window

// Explicit Function Execution
var bar = o.func1;
console.log("bar.call(o2)::", bar.call(o2)); // return the object o2

// Function as Argument Losing Surrounding Context
// Since inside func5 (which is invoked inside func4), its argument is invoked with implicit function context. This is this is the global object.
console.log("o2.func4()::", o2.func4());;
