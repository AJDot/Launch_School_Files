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

Closures are created whenever a function is defined. That function will have access to everything in that scope as long as the closure exists. The closure will even keep track of changes made to enclose variables.

Example:
```javascript
var words = 'awesome sauce';

function logWords() {
  console.log(words);
}

logWords();     // awesome sauce
words = 'not so awesome sauce';
logWords();     // not so awesome sauce
