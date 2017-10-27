# The End is Near But Not Here

The penultimate function returns the next to the last word in the String passed to it. The function assumes that "words" are any sequence of non-blank characters. It also assumes that the input String will always contain at least two words. Currently, the solution provided does not match expected result. Run the program, check the current result, identify the problem, explain what the problem is, and provide a working solution.

```javascript

function penultimate(string) {
}
```

## ANSWER
A negative index on an array will not access elements starting from the end of the array. Since arrays are object, this tries to access the value with the key of -2, which is `undefined` in this case.

The Fix:
```javascript
function penultimate(string) {
  return arr[arr.length - 2];
}

// OR

function penultimate(string) {
}
```
