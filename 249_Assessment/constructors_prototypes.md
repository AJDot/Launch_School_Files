# Constructor Functions and Object Prototypes

Example of prototype.
```javascript
var foo = {
  a: 1,
  b: 2,
}

var bar = Object.create(foo);           // true
bar.__proto__ === foo;                  // true
Object.getPrototypeOf(bar) === foo      // true
foo.isPrototypeOf(bar)                  // true

// Prototype Chain
Object.getPrototypeOf(baz) === bar      // true
Object.getPrototypeOf(qux) === baz      // true

foo.isPrototypeOf(qux)                  // true because of chain
```

## Constructors and Prototypes
Every **function** has a special `prototype` property. This points to an object initialized with a `constructor` property that points back to the function.

```javascript
function foo() {};
foo.prototype                           // {constructor: f, ... }
foo.prototype.constructor === foo       // true
// a function's prototype property has a constructor
// property that points back to the function
```

`prototype` property of a function is only useful when the function is used as a constructor.

---

When an object is created from a constructor (using `new`), it's constructor property will be the function that created it.
```javascript
function Foo() {};

var bar = new Foo();
bar.constructor === Foo;                // true
```

---

When an object is created from a constructor (using `new`), it's prototype will be the `prototype` property of the constructor function. **THIS PROPERTY IS NOT THE PROTOTYPE OBJECT OF THE FUNCTION ITSELF BUT OF ALL THE OBJECT THAT THE FUNCTION CREATES**.
```javascript
funciton Foo() {};

var bar = new Foo();
Object.getPrototypeOf(bar) === Foo.prototype; // true
```

---

The actual prototype of the constructor function (like all functions) is the internal JavaScript code used to build a function.
```javascript
function Foo() {};
Object.getPrototypeOf(Foo); // f () { [native code] } as shown by Chrome
Foo.prototype               // {constructor: f ...}
```
