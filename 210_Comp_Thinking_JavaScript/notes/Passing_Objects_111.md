# Passing Objects

## What will the following code log to the console and why?
```javascript
var a = [1, 2, 3];

function myValue(b) {
  b[2] += 7;
}

myValue(a);
console.log(a);
```

## ANSWER
```javascript
[1, 2, 10]
```
JavaScript is pass-by-value but for objects, the value passed in is the reference to it. The addition of 7 to the 3rd elements actually alters the global object. Note that the object itself has not changed but the values it holds have.