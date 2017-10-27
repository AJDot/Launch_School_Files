# Mutation
```javascript
var array1 = [1, 2, 3, 4, 5, 6, 7, 8];
var array2 = [];

for (var i = 0; i < array1.length; i++) {
  array2.push(array1[i]);
}

console.log(array1);
// [1, 2, 3, 4, 5, 6, 7, 8]
console.log(array2);
// [1, 2, 3, 4, 5, 6, 7, 8]

for (var i = 0; i < array2.length; i++) {
  array2[i] = array2[i] + 9;
}

console.log(array1);
// [1, 2, 3, 4, 5, 6, 7, 8]
console.log(array2);
// [10, 11, 12, 13, 14, 15, 16, 17]
```
No mutation of array1 because array2 was created by pushing primitive types to it from array1. JS passes these values to array2, not references to those values. When values in array2 are changed, those references will now point to different locations since that values themselves are immutable.

---
```javascript
var array3 = [[1, 2], [3, 4], [5, 6], [7, 8]];
var array4 = [];

for (var i = 0; i < array3.length; i++) {
  array4.push(array3[i]);
}

console.log(array3);
// [[1, 2], [3, 4], [5, 6], [7, 8]];
console.log(array4);
// [[1, 2], [3, 4], [5, 6], [7, 8]];

for (var i = 0; i < array4.length; i++) {
  array4[i][0] = array4[i][0] + 9;
}
console.log(array3);
// [[10, 2], [12, 4]. [14, 6], [16, 8]]
console.log(array4);
// [[10, 2], [12, 4]. [14, 6], [16, 8]]
```

Mutation occurs here because array4 was built using objects from array3. When objects are passed it is the value of their reference that is carried. The values inside each of those objects changed in both arrays because the objects themselves are still the same objects, but the values they point to just happen to be different after the reassignment.

---
```javascript
var array4 = [[1, 2], [3, 4], [5, 6], [7, 8]];
var array5 = array4.slice();

console.log(array4);
// [[1, 2], [3, 4], [5, 6], [7, 8]];
console.log(array5);
// [[1, 2], [3, 4], [5, 6], [7, 8]];

for (var i = 0; i < array5.length; i++) {
  array5[i][0] = array5[i][0] + 9;
}
console.log(array4);
// [[10, 2], [12, 4]. [14, 6], [16, 8]]
console.log(array5);
// [[10, 2], [12, 4]. [14, 6], [16, 8]]
```
slice() return a shallow copy of the array. This means that object references are copied to the new array; the original and new array refer to the same object. This results in the same behavior as above.

---
We can get around this shallow copy issue by recursively copying the objects inside the main copied object. Here is an example with object just 1 level deep inside an array. We must slice the main array, then slice each inner array.
```javascript
console.log(array6);
// [[1, 2], [3, 4], [5, 6], [7, 8]];
console.log(array7);
// [[1, 2], [3, 4], [5, 6], [7, 8]];

for (var i = 0; i < array7.length; i++) {
  array7[i][0] = array7[i][0] + 9;
}
console.log(array6);
// [[1, 2], [3, 4], [5, 6], [7, 8]];
console.log(array7);
// [[10, 2], [12, 4]. [14, 6], [16, 8]]
```
Now we have a true copy of everything from the original array. The two arrays now reference different objects and the corresponding inner arrays also reference different objects.