# Arrays
## Arrays
Indexed by non-negative integer values. The sequence of elements may or may not be important.
```javascript
[] // an empty Array

[0, 1, 2] // an Array holding three values

```

```javascript
var count = new Array(1, 2, 3);

// Usually written as:
var count = [1, 2, 3];
```

Main uses of Arrays:
* Iterating through each index and performingn an action on each value.
* Accessing and manipulating specific elements of the Array.

## Iterating through an Array
A basic `for` loop to iterate through an array (here is logs each value to the console).
```javascript
var count = [1, 2, 3, 4];
for (var i = 0; i < count.length; i++) {
  console.log(count[i]);
}
```

## Accessing, Modifying, and Detecting Values
Bracket notation is the easiest way to access an element in an Array.
```javascript
var fibonacci = [0, 1, 1, 2, 3, 5, 8, 13];

fibonacci[0];   // 0
fibonacci[3];   // 2
fibonacci[100];   // undefined
```

Add values to an Array using similar notation:
```javascript
var count = [1, 2, 3];
count[3] = 4;
count;        // [1, 2, 3, 4]
count.length; // 4
```

```javascript
// continue from the previous code snippet
count[5] = 5;
count[9] = 9;
count;            // [1, 2, 3, 4, undefined x 1, 5, undefined x 3, 9]
count[4];         // undefined
count.length;     // 10
```

Change the length of an Array:
```javascript
var count = [1, 2, 3];

count.length = 10;
count;              // [1, 2, 3, undefined x 7]
count.length = 2;
count;              // [1, 2]; excess elements are lost
```

## Arrays are Objects
```javascript
```
If you need to find out if an object is an Array, use `Array.isArray()`.
```javascript
Array.isArray([]);          // true
```

## Array Methods
My implementations of basic array methods.
```javascript
function push(arr, value) {
  arr[arr.length] = value;
  return arr.length;
}

function pop(array) {
  newLength = array.length - 1;
  var value = array[newLength];
  array.length = newLength
  return value;
}

function unshift(array, value) {
  for (var i = array.length; i > 0; i--) {
    array[i] = array[i - 1];
  }

  array[0] = value;
  return array.length;
}

function shift(array) {
  var first = array[0];
  for (var i = 0; i < array.length; i++) {
    array[i] = array[i + 1];
  }

  array.length -= 1;
  return first;
}

function indexOf(array, value) {
  for (var i = 0; i < array.length; i++) {
    if (array[i] === value) {
      return i;
    }
  }

  return -1;
}

function lastIndexOf(array, value) {
  for (var i = array.length - 1; i >= 0; i--) {
    if (array[i] === value) {
      return i;
    }
  }

  return -1;
}

function slice(array, begin, end) {
  var newArray = [];
  for (var i = begin; i < end; i++) {
    push(newArray, array[i]);
  }

  return newArray;
}

function splice(array, begin, number) {
  var removedValues = [];
  for (var i = begin; i < array.length; i++) {
    if (i < begin + number) {
      push(removedValues, array[i]);
    }

    array[i] = array[i + number];
  }

  array.length = array.length - number;
  return removedValues;
}

function concat(array1, array2) {
  newArray = [];
  for (var i = 0; i < array1.length; i++) {
    push(newArray, array1[i]);
  }

  for (var i = 0; i < array2.length; i++) {
    push(newArray, array2[i]);
  }

  return newArray;
}

function join(array, separator) {

  for (var i = 0; i < array.length; i++) {
    result += String(array[i]);

    if (i < array.length - 1) {
      result += separator;
    }
  }

  return result;
}
```