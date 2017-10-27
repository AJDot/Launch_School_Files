# Closures and Function Scope

## Closures and Function Review
Functions can be defined using two different syntaxes:
```javascript
// This is the named function syntax
function hello() {
}

// This is the function expression syntax
var hello = function() {
}
```
**Function expression** syntax is useful when passing a function to another function as an argument or return value.
```javascript
var squares = [1, 2, 3, 4, 5].map(function(number) {
  return math.Pow(number, 2);
});
```

All functions obey these lexical scoping rules:
* it can access any variables defined within it.
* It can access any varaibles that were in scope based on teh context where the function was **defined**.