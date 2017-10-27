# Accidentally Global

## What will the following code log to the console and why?
```javascript
function someFunction() {
}

someFunction();
console.log(myVar);
```

## ANSWER
`This is global` will be logged. With the use of `var` to declare the variable as a local variable, `myVar` is binded to be a "property" of the `global` object. This is "almost" the same as declaring it as a global variable.