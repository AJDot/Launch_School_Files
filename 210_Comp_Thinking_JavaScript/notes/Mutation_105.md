# Mutation

## What will the following code log to the console and why?
```javascript
var array2 = [];

for (var i = 0; i < array1.length; i++) {
  array2.push(array1[i]);
}

for (var i = 0; i < array1.length; i++) {
    array1[i] = array1[i].toUpperCase();
  }
}

console.log(array2);
```

## ANSWER
```
```
JavaScript is pass-by-value which means for primitive types the value is passed not the reference to the value. When each value is pushed to array2, the reference is not, meaning it is not referencing the same location that the value is referencing in array1. Additionally, array2 is declared as a new object, so it points to a different location that array1.

In other words, the values passed to array2 are immutable values, strings. array2 itself is a mutable object but it is distinct from array1.

If an object was an element of array1 and got pushed to array2, changes to that object would be reflected in both array1 and array2.

To make any change in array1 reflected in array2, change line 2 to `var array2 = array1` and remove the first `for` statement.