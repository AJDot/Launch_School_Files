# Hoisting Variables

## What will the following code log to the console and why?
```javascript
console.log(a);

var a = 1;
```

## ANSWER
```javascript
undefined
```
Variable declarations are hoisted to the top of their current scope but variable assignments are not. This means that `a` will be declared before `console.log(a)` but it will not be assigned to `1`. An unassigned variable is assigned to `undefined`.
This is essentially what is happening.
```javascript
var a;
console.log(a);

a = 1;
```