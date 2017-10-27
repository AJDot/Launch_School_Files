# Array Copy 2

## Implement 2 alternative ways of copying just the values and not the reference.
```javascript
// Option 1
var myArray = [1, 2, 3, 4];
var myOtherArray = myArray.slice();
myArray.pop();
console.log(myArray);
console.log(myOtherArray);

// Option 2
var myArray = [1, 2, 3, 4];
var myOtherArray = [];
for (var i = 0; i < myArray.length; i += 1) {
  myOtherArray.push(myArray[i]);
}
myArray.pop();
console.log(myArray);
console.log(myOtherArray);
```