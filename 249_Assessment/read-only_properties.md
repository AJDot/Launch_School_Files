# Creating Read-Only Properties and Methods

Use `Object.defineProperties()` to achieve this.

```javascript
var obj = {
  name: 'Obj',
};

Object.defineProperties(obj, {
  age: {
    value: 30,
    writable: false,
  }
});

// Contrived example
console.log(obj.age); // 30
obj.age = 32;
console.log(obj.age); // 30
```

```javascript
function newPerson(name) {
  var obj = {
    name: name,
  };

  Object.defineProperties(obj, {
    log: {
      value: function() {
        console.log(this.name);
      },
      writable: false,
    }
  });

  return obj;
}

var me = newPerson('Alex Henegar');
me.log();   // Alex Henegar
me.log = function() { console.log("Someone Else"); };
me.log();   // Alex Henegar
```
