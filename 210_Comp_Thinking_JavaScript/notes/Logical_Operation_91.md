# Logical Operation

What will the output of each line be?
```javascript
(false && undefined);
(false || undefined);
((false && undefined) || (false || undefined));
((false || undefined) || (false && undefined));
((false && undefined) && (false || undefined));
((false || undefined) && (false && undefined));
```

## ANSWER
There are only 6 falsy values:
```javascript
false
undefined
null
0
NaN
```
`&&` returns the first expression if it can be converted to `false`; otherwise the second is returned.
`||` return the first expression if it can be converted to `true`; otherwise the second is returned.
So:
```javascript
(false && undefined);                           // false
(false || undefined);                           // undefined
((false && undefined) || (false || undefined)); // undefined
((false || undefined) || (false && undefined)); // false
((false && undefined) && (false || undefined)); // false
((false || undefined) && (false && undefined)); // undefined
```
