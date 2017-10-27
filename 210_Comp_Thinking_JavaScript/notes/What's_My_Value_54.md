(Quirks of arrays as objects in reference to the value of `Array.length`)

What will the following program log to the console?
```javascript

console.log(arr.length);
console.log(Object.keys(arr).length);

console.log(arr.length);
console.log(Object.keys(arr).length);
```

## ANSWER
```
3
4
3
5
```
This is because the `length` property of arrays only counts keys with non-negative integer values.