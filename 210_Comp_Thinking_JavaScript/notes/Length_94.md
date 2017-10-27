# Length

What values will it log to the console?
```javascript
console.log(languages);
console.log(languages.length);

languages.length = 4;
console.log(languages);
console.log(languages.length);

languages.length = 1;
console.log(languages);
console.log(languages.length);

languages.length = 3;
console.log(languages);
console.log(languages.length);

languages.length = 1;
console.log(languages);
console.log(languages[1]);
console.log(languages.length);
```

## ANSWER
```
["JavaScript", "Ruby", "Python"]
3
["JavaScript", "Ruby", "Python", empty x 1]
4
["JavaScript"]
1
["JavaScript", empty x 2]
3
["JavaScript", empty x 1, "Python"]
undefined
3
```