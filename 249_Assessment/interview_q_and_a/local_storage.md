# How do you work with `localStorage` and why would you want to?

You can work with `localStorage` by using two methods, `setItem` and `getItem`. They work with relative ease as such:
```javascript
localStorage.setItem('color', '#ffffff');

localStorage.getItem('color');
```

Now there will be a key in the localStorage called `color` and it will contain the value of `#ffffff`.

It is only possible to store strings in local storage so to save more complex objects, use JSON to `parse` and `stringify` them.

```javascript
var complex = {
  account: 1234,
  secret: "I like pancakes",
}

localStorage.setItem('complex', JSON.stringify(complex));

JSON.parse(localStorage.getItem('complex'));
```

`localStorage` is preferred for a few reasons. It can hold up to 5MB of data vs. the 4KB that cookies can hold. `localStorage` is easy to work with since storage is in the form of key/value pairs and there are built-in methods to set and get those values.
