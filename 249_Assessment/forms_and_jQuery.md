# How to Interact with Forms Using jQuery

This code will take the form data and any input that has a `name` and `value` property will be serialized into an object with two properties `name` and `value`. All the objects created (one for each input) will be returned in an array of Objects.
```javascript
function getFormObject($f) {
  var o = {};

  $f.serializeArray().forEach(function(input) {
    o[input.name] = input.value;
  });

  return o;
}
```

Here is a version that should put multiple values for the same name into an array - like for a multiple select input.
```javascript
function getFormObject($f) {
  var o = {};

  $f.serializeArray().forEach(function(input) {
    if (!o.hasOwnProperty(input.name)) {
      o[input.name] = input.value;
    } else if (typeof o[input.name] === "string") {
      o[input.name] = [o[input.name]];
      o[input.name].push(input.value);
    } else {
      o[input.name].push(input.value);
    }
  });

  return o;
}
```
