# Immediately Invoked Function Expressions
A function defined and invoked simultaneously.

```javascript
(function() {
  console.log('hello');
})();                         // hello

(function(a) {
  console.log(a + 10);
})(20);                       // 30

// parentheses can be omitted if function declaration is part of an expression that doesn't occur at the beginning of the line.
var foo = function() {
  return function() {
    return 10;
  }();
}();

console.log(foo)              // 10
```

Using IIFEs hide variables from the rest of the program since they create their own scope.
```javascript
(function() {
  for (var i = 0; i < 100; i++) {
    console.log(i);
  }
})();
```

This code does not have the risk of modifying the variable `i` outside of its closure (if the variable `i` is being used). It also is not a named function so we don't have to worry about overwriting a variable with whatever name we give it.

IIFEs are a way to create "module"-like behavior.
