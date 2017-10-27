# Array Object 2

## The user of the function put in the statements below and was expecting the function to return 5 to test it. What is the value returned?
```javascript
var myArray = [5, 5];
myArray[-1] = 5;
myArray[-2] = 5;
function average(array) {
  var sum = 0;
  for (var i = -2; i < array.length; i++) {
    sum += array[i];
  }

  return sum / array.length;
}

average(myArray);
```

## ANSWER
```
10
```

`myArray` looks like `[5, 5, -1: 5, -2: 5]`. The `length` property of an array will count the number of non-negative integer keys. In this case there are two of them (0 and 1). The call to the function looks like this:
```javascript
var sum = 0;
for (var i = -2; i < 2; i++) {
  sum += array[i];
}

return sum / 2;
```
It will sum up values for the keys -2, -1, 0, and 1. This totals 20 and when divided by the array length, results in 10.
