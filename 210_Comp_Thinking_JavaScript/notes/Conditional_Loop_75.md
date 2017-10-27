# Conditional Loop

Will this code log multiples of 3 from 0 to 9?
```javascript
var i = 0;
while (i < 10) {
  if (i % 3 === 0) {
    console.log(i);
  } else {
    i += 1;
  }
}
```

## ANSWER
No, the iterator `i` will not be updated if `i % 3 === 0` which means `i` will remain `0` indefinitely since `0 % 3 === 0`.