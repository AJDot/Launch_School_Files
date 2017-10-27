# Pass by Value with Shadowing

## what will the following code log to the console and why?
```javascript
var a = 7;

function myValue(a) {
  a += 10;
}

myValue(a);
console.log(a);
```

## ANSWER
```javascript
7
```
`myValue(a)` takes the global variable `a`, has a value of `7`, and assigns its value to the local variable `a` inside the `myValue` Function. This local variable shadows the outer variable making it the variable change inside the function, not the global variable.