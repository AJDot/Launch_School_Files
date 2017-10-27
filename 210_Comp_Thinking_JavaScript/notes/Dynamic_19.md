# Dynamic

## What gets logged by lines 11 and 12?
```javascript
var myObject = {
};


console.log(myObject[prop2]);
console.log(myObject.prop2);
```

## ANSWER
After line 9, `myObject` looks like:
```javascript
{
}
```

```
Line 11: "678"
Line 12: "456"
```