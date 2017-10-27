# Hoisting Functions

## What will the following code log to the console and why?
```javascript
logValue();

function logValue() {
}
```

## ANSWER
Functions declarations are hoisted to the top of their scope. Unlike with variables, the entire declaration is hoisted, including the block. Effectively the code looks like this:
```javascript
function logValue() {
}

logValue();
```
The code will log `Hello, world!` to the console.

## Further
### What does it log now? What is the hoisted equivalent of this code?
```javascript

function logValue() {
}

console.log(typeof logValue);
```
This will log `string`. Functions are hoisted above varables. The hoisted code is as follows:
```javascript
function logValue() {
}
var logValue;

console.log(typeof logValue);
```