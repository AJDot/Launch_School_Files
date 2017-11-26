# Asynchronous JavaScript

---

Example:

```javascript
function makeLogger(i) {
  return function() {
    console.log(i);
  }
}

function delayLog() {
  for (var i = 1; i <= 10; i++) {
    var logger = makeLogger(i);
    setTimeout(logger, i * 1000);
  }
}

delayLog();
```
 We need closure around the text that will be printed. If this is not done then when the `loggers` finally run, `i` will be 11 and that will be printed 10 times. Remember that a closure when using `setTimeout` and so it remembers `i` and follows its changes. The `makeLogger` function creates a closure around `i` which ensures that the right value of `i` gets logged each time.

---
Example:
```javascript
var count = 1;
function logger(text) {
  console.log(text);
  count++
}

var int = setInterval(function() {
  logger(count);
  if (count > 10) { clearInterval(int) ; }
}, 500);
```
This is an interval that runs until the count is greater than 10.
`count` is a global variable so `logger` and `setInterval` can watch it.

---
