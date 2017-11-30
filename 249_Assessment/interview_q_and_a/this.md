# What does `this` refer to?

`this` is always an object that represents the function execution context. For example, when used at the top-level of a program, `this` will refer to the global context object, usually `window`. One key feature of `this` is that it is determined at function *execution*, not function declaration.

Example:
```javascript
var name = "Alex";

console.log(this.name);               // "Alex"
```

The execution context here is the global object `window`. So executing `this.name` is the same as `window.name`, which was assigned the value `"Alex"` on line 1.

Example:
```javascript
var name = "Alex";

var obj = {
  name: "Bill",
  getName: function() {
    return this.name;
  },
}

console.log(this.name);                 // Alex
console.log(obj.getName);               // Bill
```

The first log works as before. The second logs `this.name` as before, but in this instance, `this` has become the `obj` object since that is the execution context of the `getName` method. Inside that method for this particular case `this.name` is the same as `obj.name` (not `window.name`).
