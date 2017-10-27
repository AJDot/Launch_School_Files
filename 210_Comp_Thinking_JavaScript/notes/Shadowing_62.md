# Shadowing

## What will the following code log to the console and why?
```javascript

functions someFunction() {
  console.log(myVar);
}

someFunction();
```

## ANSWER
JavaScript searches for the reference of a variable starting from the inner-most scope and working upward through the global scope. The first value found will be used. Here, since `myVar` is declared inside `someFunction` on line 4 which is an inner scope of the global scope, its value will be used (`This is local`) instead of the value assigned on line 1. This is called variable shadowing, where another variable with the same name but in an inner scope blocks access to that variable name from an outer scope.