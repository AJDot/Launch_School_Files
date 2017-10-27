# Pass by Value

## What will the following code log to the console and why?
```javascript
var a = 7;

function myValue(b) {
  b += 10;
}

myValue(a);
console.log(a);
```

## ANSWER
```javascript
7
```
JavaScript is a pass-by-value language which means that references to the variables are not passed in, a copy of the value is passed in and bound to the local variable `b`. When the value of `a` is attempted to be alter by `myValue(a)`, it is really the local variable `b` that is being altered. `a` itself remains unchanged.