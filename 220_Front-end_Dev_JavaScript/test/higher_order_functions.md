# Higher Order Functions
A higher order functions must either:
* accept a function as an argument, or
* return a function

```javascript
function lettersAreUpperCase(text) {
  return !/[a-z]+/g.test(text);
}

function reject(array, callback) {
  return array.filter(function(item) {
    return !callback(item);
  });
}

Array.prototype.reject = function(callback) {
  return this.filter(function(item) {
    return !callback(item);
  });
}

var texts = [
  "FALSE Something for nothing.",
  "TRUE NOTHING FOR EVERYTHING",
  "TRUE OTHER CHARACTER5 ARE IN H3R3.",
  "FALSE OTHER CHARACTER5 are IN H3R3."
];

// contains 2nd and 3rd items in array
var allUpperCaseTexts = texts.filter(lettersAreUpperCase);

// contains 1st and 4th items in array
var notAllUpperCaseTexts = reject(texts, lettersAreUpperCase);

// I created a new method for arrays similar to `reject` in Ruby
// It uses `filter` but return the opposite
// `reject` used below returns the array where elements that have all
// letter uppercased are removed
var notAllUpperCaseTexts2 = texts.reject(lettersAreUpperCase);

console.log(allUpperCaseTexts);
console.log(notAllUpperCaseTexts);
console.log(notAllUpperCaseTexts2);
```
