# this

`this` does not follow lexical scoping rules.
`this` depends on the execution context

```javascript
// During Method Invocation
// this is a reference to the object itself
var obj = {
  name: 'obj',
  count: 0,
  increment: function() {
    this.count++;
  },
  whatIsThis: function() {
    return this;
  }
}

console.log(obj.whatIsThis()); // returns obj
console.log(obj);
obj.increment();
console.log(obj);

// windowFunction is now being executed in the top scope so
// its execution context is the global object, which is the `window` object.
var windowFunction = obj.whatIsThis;
console.log(windowFunction()); // returns [window] object


// Implicit Function Execution Context
// function is invoked without explicit context (no caller)
// binding is the owning object

// both of these are implicit executions
console.log(windowFunction());       // return the Window object
console.log(obj.whatIsThis());  // returns the object obj


// Explicit Function Execution Context
// Uses call or apply to "borrow" methods
var obj2 = {
  name: 'obj2',
  count: 10,
  increment: function() {
    this.count += 10;
  }
}
console.log(obj.whatIsThis.call(window)); // returns the Window object
console.log(obj.whatIsThis.call(obj)); // returns the obj object
console.log(obj.whatIsThis.call(obj2)); // returns the obj2 object

// Can use obj2.increment to increase the count in obj by 10
obj2.increment.call(obj);
console.log(obj);

// Can borrow whatIsThis from obj to find out what this is in obj2
console.log(obj.whatIsThis.call(obj2));

// Hard Binding Functions with Contexts
// use bind to set a permanent execution context for functions
// this return a copy of the function but with a permanent execution context.
var foo = obj.increment.bind(obj);
// now foo with call increment with obj always being the context.
console.log(obj);
console.log(obj2);
foo();
console.log(obj);
foo.call(obj2);     // still calls on obj, call and apply can't change that anymore
console.log(obj);
console.log(obj2);
