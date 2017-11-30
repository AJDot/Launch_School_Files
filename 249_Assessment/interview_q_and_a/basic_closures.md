# Describe the basics of closures

Example:
```javascript
function makeCounter(start, stop) {
  return function() {
    for (var i = start; i <= stop; i++) {
      console.log(i);
    }
  }
}

var counter = makeCounter(3, 9);
counter();                          // logs 3, 4, 5, 6, 7, 8, 9
counter.start;                      // ReferenceError: start is not defined
```

Here, `start` and `stop` are enclosed by `makeCounter` and allows the return function (assigned to `counter`) to have access to them. So later on in the program, long after when `start` and `stop` may no longer be in scope, `counter` will still have access to them.
