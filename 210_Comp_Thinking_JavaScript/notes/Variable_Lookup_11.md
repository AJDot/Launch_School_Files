# Variable Lookup

## What will the following code log to the console and why?
```javascript

function someFunction() {
  console.log(myVar);
}

someFunction();
```

## ANSWER
`This is global` will be logged to the console. Inner scopes have access to variable in outer scopes. JavaScript searches for variable values starting at the inner-most scope. Here, it did not find `myVar` inside the scope of the Function `someFunction`. The next outer scope is the global scope, where `myVar` does exist.