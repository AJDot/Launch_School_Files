# Accessing Global

## What will the following code log to the console and why?
```javascript

function someFunction() {
}

someFunction();

console.log(myVar);
```

## ANSWER
Variable from an outer scope can be accessed by inner scopes. This means the value of `myVar` gets reassigned on line 4. `This is local` will be logged to the console.