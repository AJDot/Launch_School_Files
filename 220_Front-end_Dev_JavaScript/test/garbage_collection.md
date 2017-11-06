# Garbage Collection

JavaScript is a GC language which means it automatically handles memory allocation and deallocation.

Garbage collection **occurs** when there are no more references to the object.
Garbage collection **does not** occur because a variable goes out of scope.
If references to the object or value that it referenced still exist, then a variable cannot be garbage collected.

Theoretically, if the closure exists then all the variables and values they are referencing can't be garbage collected.
`null` a closure to completely removed it.
```javascript
function awesome() {
  // do stuff
  return function() { console.log("stuff"); }
}

var doIt = awesome();

doIt = null;
```
