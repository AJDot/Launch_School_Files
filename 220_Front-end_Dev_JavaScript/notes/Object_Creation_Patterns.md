# Object Creation Patterns
<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Object Creation Patterns](#object-creation-patterns)
  * [Factory Functions](#factory-functions)
  * [Constructor Functions](#constructor-functions)
  * [Objects and Prototypees](#objects-and-prototypees)
    * [Object's Prototypes](#objects-prototypes)
      * [Prototype Chain and the Object.prototype Object](#prototype-chain-and-the-objectprototype-object)
  * [Prototypal Inheritance and Behavior Delegation](#prototypal-inheritance-and-behavior-delegation)
    * [Prototype Chain Lookup for Property Access](#prototype-chain-lookup-for-property-access)
    * [Prototypal Inheritance and Behavior Delegation](#prototypal-inheritance-and-behavior-delegation-1)
    * [Overriding Default Behavior](#overriding-default-behavior)
    * [Object.getOwnPropertyNames and object.hasOwnProperty](#objectgetownpropertynames-and-objecthasownproperty)
    * [Methods on Object.prototype](#methods-on-objectprototype)
  * [Practice Problems: Prototypes and Prototypal Inheritance](#practice-problems-prototypes-and-prototypal-inheritance)
  * [Constructors and Prototypes](#constructors-and-prototypes)
  * [The Pseudo-classical Pattern and the OLOO Pattern](#the-pseudo-classical-pattern-and-the-oloo-pattern)
    * [Object Creation Considerations](#object-creation-considerations)
    * [The Pseudo-classical Pattern](#the-pseudo-classical-pattern)
    * [The OLOO Pattern](#the-oloo-pattern)
    * [Further Reading](#further-reading)
  * [More Methods on the Object Constructor](#more-methods-on-the-object-constructor)
    * [Object.create() and Object.getPrototypeOf()](#objectcreate-and-objectgetprototypeof)
    * [Object.defineProperties()](#objectdefineproperties)
    * [Object.freeze()](#objectfreeze)
  * [Summary](#summary)

<!-- tocstop -->
erns
## Factory Functions
aka 'Factory Object Creation Pattern'
```javascript
function createPerson(firstName, lastName) {
  return {
    firstName: firstName,
    lastName: lastName || '',
    fullName: function() {
      return (this.firstName + ' ' + this.lastName).trim();
    }
  };
}

var john = createPerson('John', 'Doe');
var jane = createPerson('Jane');
```

Disadvantages:
* every object created with the factory function has a full copy of all the methods, which can be redundant.
* there isn't a way for us to inspect an object and know whether it's create from a factory function. This makes it difficult to identify whether an object is of a specific "type".

Example: Invoice Processing
Code for one invoice.
```javascript
var invoice = {
  phone: 3000,
  internet: 6500
};
var payment = {
  phone: 1300,
  internet: 5500
};
var invoiceTotal = invoice.phone + invoice.internet;
var paymentTotal = payment.phone + payment.internet;
var remainingDue = invoiceTotal - paymentTotal;

console.log(paymentTotal);         // 6800
console.log(remainingDue);         // 2700
```
Make code for multiple invoices.
```javascript
function createInvoice(services) {
  var services = services || {};
  return {
    phone: services.phone || 3000,
    internet: services.internet || 5500,
    payments: [],
    total: function() {
      return this.phone + this.internet;
    },
    addPayment: function(payment) {
      this.payments.push(payment);
    },
    addPayments: function(payments) {
      payments.forEach(function(payment) {
        this.addPayment(payment);
      });
    },
    paymentTotal: function() {
      var paymentTotal = 0;
      this.payments.forEach(function(payment) {
        paymentTotal += payment.total();
      })

      return paymentTotal;
    }
    amountDue: function() {
      return this.total() - this.paymentTotal();
    },
  }
}

function invoiceTotal(invoices) {
  var total = 0;
  for (var i = 0; i < invoices.length; i++) {
    total += invoices[i].total();
  }

  return total;
}

var invoices = [];
invoices.push(createInvoice());
invoices.push(createInvoice({
 internet: 6500
}));

invoices.push(createInvoice({
 phone: 2000
}));

invoices.push(createInvoice({
  phone: 1000,
  internet: 4500
}));

console.log(invoiceTotal(invoices));             // 31000
```

Code for payments
```javascript
function createPayment(services) {
  var services = serivces || {};
  return {
    phone: services.phone || 0,
    internet: services.internet || 0,
    amount: services.amount,
    total: function() {
      return this.amount || (this.phone + this.internet);
    }
  }
}

function paymentTotal(payments) {
  var total = 0;
  for (var i = 0; i < payments.length; i++) {
    total += payments[i].total();
  }

  return total;
}

var payments = [];
payments.push(createPayment());
payments.push(createPayment({
  internet: 6500
}));

payments.push(createPayment({
  phone: 2000
}));

payments.push(createPayment({
  phone: 1000, internet: 4500
}));

payments.push(createPayment({
  amount: 10000
}));

console.log(paymentTotal(payments));      // 24000
```

## Constructor Functions
```javascript
function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName || '';
  this.fullName = function() {
    return (this.firstName + ' ' + this.lastName).trim();
  }
}

var john = new Person('John', 'Doe');
var jane = new Person('Jane');

john.fullName();              // "John Doe"
jane.fullName();              // "Jane"

john.constructor;             // function Person(..)
jane.constructor;             // function Person(..)

john instanceof Person;       // true
jane instanceof Person;       // true
```

This is a constructor function used to create objects. It is intended to be **called with the *new* operator**. It is convention to capitalize the name of constructor functions.

When the `new` operator is used to call a function:
1. A new object is created.
2. `this` in the function is pointed to the new object
3. The code in the function is executed.
4. `this` is returned if there's not an explicit return.

## Objects and Prototypees
### Object's Prototypes
Every JavaScript Object has a special `__proto__` property that points to another object. When `Object.create` is used to create an object, `__proto__` can be used to set the `__proto__` property on it.
```javascript
var foo = {
  a: 1,
  b: 2,
};

var bar = Object.create(foo);
bar.__proto__ === foo;          // true
```

Here, `foo` is the **prototype object** of the `bar` object.

This is standardized in ECMAScript 6 but for compatibility it shouldn't be used. Instead used these:
* `Object.getPrototypeOf(obj)` to get the prototype object of `obj`.
* `obj.isPrototypeOf(foo)` to check if `obj` is the prototype object of `foo`

#### Prototype Chain and the Object.prototype Object

```javascript
var bar = Object.create(foo);
var baz = Object.create(bar);
var qux = Object.create(baz);

foo.isPrototypeOf(qux);                   // true - because foo is on qux's prototype chain
```

## Prototypal Inheritance and Behavior Delegation
### Prototype Chain Lookup for Property Access
When accessing a property or a method on an object, JavaScript will search up the prototype chain until the end is reached.

### Prototypal Inheritance and Behavior Delegation
Can store an object's data and behaviors anywhere on the prototype chain. Powerful was to share data or behaviors.
```javascript
var dog = {
  say: function() {
    console.log(this.name + ' says Woof!');
  },

  run: function() {
    console.log(this.name + ' runs away.');
  }
};

var fido = Object.create(dog);
fido.name = 'Fido';
fido.say();               // Fido says Woof!
fido.run();               // Fido runs away.

var spot = Object.create(dog);
spot.name = 'Spot';
spot.say();               // Spot says Woof!
spot.run();               // Spot runs away.
```

This delegation gives several advantages:
* We can create dogs much more easily with the `dog` prototype, and don't have to duplicate `says` and `run` on every single dog object.
* If we need to add/remove/update behavior to apply to all dogs, we can just modify the prototype object, and all dogs will pick up the changed behavior automatically.

This is sometimes referred to as **Prototypal Inheritance**.
This pattern is also called **Behavior Delegation**.

### Overriding Default Behavior
If methods are defined locally, they will override ones up the prototype chain.

### Object.getOwnPropertyNames and object.hasOwnProperty
`obj.prop === undefined` will return `true` if `prop` is anywhere on `obj`'s prototype chain.
* The `hasOwnProperty` method on an object can test if a property is defined on the object itself
* The `Object.getOwnPropertyNames` method can return you an array of an object's own property names.

### Methods on Object.prototype
`Object.prototype` is the top-most of all JavaScript objects' prototype chain. here are some useful methods that can be called on any object.

* `Object.prototype.toString()`: returns a string representation of the object
* `Object.prototype.isPrototypeOf(obj)`: tests if the object is in another object's prototype chain.
* `Object.prototype.hasOwnProperty(prop)`: tests whether the property is defined on the object itself.

## Practice Problems: Prototypes and Prototypal Inheritance

1.
```javascript
function getDefiningObject(object, propKey) {
  while (object && !object.hasOwnProperty(propKey)) {
    object = Object.getPrototypeOf(object);
  }

  return object;
}

var foo = {
  a: 1,
  b: 2
};

var bar = Object.create(foo);
var baz = Object.create(bar);
var qux = Object.create(baz);

bar.c = 3;

console.log(getDefiningObject(qux, 'c') === bar);     // true
console.log(getDefiningObject(qux, 'e'));             // null
```

2. Create a shallow copy with same prototype chain.
```javascript
function shallowCopy(object) {
  var result = Object.create(Object.getPrototypeOf(object));
  for (var prop in object) {
    if (Object.prototype.hasOwnProperty.call(object, prop)) {
      result[prop] = object[prop];
    }
  }

  return result;
}

// OR
function shallowCopy(object) {
  var copy = Object.create(Object.getPrototypeOf(object));

  Object.getOwnPropertyNames(object).forEach(function(prop) {
    copy[prop] = object[prop];
  });

  return copy;
}

var foo = {
  a: 1,
  b: 2
};

var bar = Object.create(foo);
bar.c = 3;
bar.say = function() {
  console.log("c is " + this.c);
}

var baz = shallowCopy(bar);
console.log(baz.a);       // 1
baz.say();                // c is 3
```
3. Write a function that extends an object (destination object) with contents from multiple objects (source objects).

```javascript
function extend(destination) {
  for (var i = 1; i < arguments.length; i++) {
    var source = arguments[i];
    for (var prop in source) {
      if (Object.prototype.hasOwnProperty.call(source, prop)) {
        destination[prop] = source[prop];
      }
    }
  }

  return destination;
}

var foo = {
  a: 0,
  b: {
    x: 1,
    y: 2
  }
};

var joe = {
  name: 'Joe'
};

var funcs = {
  sayHello: function() {
    console.log('Hello, ' + this.name);
  },
  sayGoodBye: function() {
    console.log('Goodbye, ' + this.name);
  }
};

var object = extend({}, foo, joe, funcs);

console.log(object.b.x);          // 1
object.sayHello();                // Hello, Joe
```


## Constructors and Prototypes
Every **function** has a special `prototype` property. The object this points to is initialized with a `constructor` property that points back to the function.

Example:
```javascript
function foo() {};
var obj = foo.prototype;
Object.getOwnPropertyNames(obj);      // ["constructor"]
obj.constructor === foo;              // true
```

`prototype` for functions is only useful when the function is used as a constructor.
Objects created from a Function share the same prototype object. This is typically call "this constructor function's prototype object"
```javascript
var Foo = function() {};
var Qux = function() {};

Foo.__proto__ === Foo.prototype;                // false
Object.getPrototypeOf(Foo) === Foo.prototype;   // false

Qux.__proto__ === Qux.prototype;                // false
Object.getPrototypeOf(Qux) === Foo.prototype;   // false

var bar = new Foo();
Object.getPrototypeOf(bar) === Foo.prototype;   // true

var baz = new Qux();
Object.getPrototypeOf(baz) === Qux.prototype;   // true
```

We can use a constructor function and its "prototype object" to set up behavior delegation.
```javascript
var Dog = function() {};

Dog.prototype.say = function() {
  console.log(this.name + ' says Woof!');
}

Dog.prototype.run = function() {
  console.log(this.name + ' runs away.');
}

var fido = new Dog();
fido.name = 'Fido';
fido.say();             // Fido says Woof!
fido.run();             // Fido runs away.

var spot = new Dog();
spot.name = 'Spot';
spot.say();             // Spot says Woof!
spot.run();             // Spot runs away.
```

This pattern of using constructor functions to create objects, but defining shared behaviors on the constructor's `prototype` object, is called the "Prototype Pattern" of object creation.

```javascript
function Circle(radius) {
  this.radius = radius;
  this.area = function() {
    return Math.PI * this.radius * this.radius;
  }
}

// OR

function Circle(radius) {
  this.radius = radius;
};

Circle.prototype.area = function() {
  return Math.PI * this.radius * this.radius;
}
```

```javascript
function Ninja() {
  this.swung = false;
}

var ninjaA = new Ninja();

Ninja.prototype.swing = function() {
  this.swung = true;
  return this;
}

console.log(ninjaA.swing().swung);
```

This pattern of "chainable" method invocation on an object requires methods defined on the prototype to always return the context object (in this case, `ninjaA`).

```javascript
var ninjaA = (function() {
  function Ninja(){};
  return new Ninja();
})();

var ninjaB = Object.create(ninjaA);
// OR
var ninjaB = new ninjaA.constructor();

console.log(ninjaB.constructor === ninjaA.constructor)    // this should be true
```

1. Follow the steps below:

    1. Create an object called shape that has a type property and a getType method.
    2. Define a Triangle constructor function whose prototype is shape. Objects created with Triangle should have three own properties: a, b and c representing the sides of a triangle.
    3. Add a new method to the prototype called getPerimeter.

```javascript
var shape = {
  type: '',
  getType: function() {
    return this.type;
  }
}

function Triangle(a, b, c) {
  this.type = 'triangle';
  this.a = a;
  this.b = b;
  this.c = c;
}
Triangle.prototype = shape;

Triangle.prototype.getPerimeter = function() {
  return this.a + this.b + this.c;
}

Triangle.prototype.constructor = Triangle;

var t = new Triangle(1, 2, 3);
t.constructor;                 // Triangle(a, b, c)
shape.isPrototypeOf(t);        // true
t.getPerimeter();              // 6
t.getType();                   // "triangle"
```
> Need to set the constructor to the proper value. Typically this is done automatically because a function's prototype object will automatically have a property `constructor` pointing to the function. However in this case, since we pointed the `Triangle` function's prototype to `shape`, we lost that `constructor` reference. Therefor we have to set it back manually.

---

Write a constructor function that can be used with or without the new operator, and return the same result in either form. Use the code below to check your solution:

```javascript
function User(first, last) {
  if (!this.instanceOf(User)) {
    return new User(first, last)
  }

  this.name = first + ' ' + last;
}

var name = 'Jane Doe';
var user1 = new User('John', 'Doe');
var user2 = User('John', 'Doe');

console.log(name);        // Jane Doe
console.log(user1.name);   // John Doe
console.log(user2.name);   // John Doe
```

Constructor functions built this way are called "scope-safe constructors". Most of javaScript's built-in constructors, such as `Object`, `Regex`, and `Array`, are scope-safe.
```javascript
new Object();       // Object {}
Object();       // Object {}
new Array(1, 2, 3);       // [1, 2, 3]
Array(1, 2, 3);       // [1, 2, 3]
```

---
Create a function that can create an object with a given object as its prototype, without using Object.create.

```javascript
function createObject(obj) {
  function F() {};
  F.prototype = obj;
  return new F();
}

var foo = {
  a: 1
};

var bar = createObject(foo);
foo.isPrototypeOf(bar);         // true
```

> We can create a temporary constructor function, set its prototype object to the argument, then create an object based on the constructor. In fact, this is a simplified implementation for `Object.create` itself!

---

Similar to the problem above, create a `begetObject` function that you can call on any object to create an object inherited from it:

```javascript
Object.prototype.begetObject = function() {
  function F() {}
  F.prototype = this;
  return new F();
}

var foo = {
  a: 1
};

var bar = foo.begetObject();
foo.isPrototypeOf(bar);         // true
```

---

Create a function neww, so that it works like the new operator:
```javascript
function neww(constructorr, args) {
  var object = Object.create(constructorr.prototype);
  var result = constructorr.apply(object, args);

  object.constructor = constructorr;
  return result === undefined ? object : result;
}

function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}

Person.prototype.greeting = function() {
  console.log('Hello, ' + this.firstName + ' ' + this.lastName);
}

var john = neww(Person, ['John', 'Doe']);
john.greeting();          // Hello, John Doe
john.constructor;         // Person(firstName, lastName) {...}
```

## The Pseudo-classical Pattern and the OLOO Pattern

### Object Creation Considerations
Example: a point object
```javascript
var pointA = {
  x: 30,
  y: 40,

  onXAxis: function() {
    return this.y === 0;
  },

  onYAxis: function() {
    return this.x === 0;
  },

  distanceToOrigin:  function() {
    return Math.sqrt((this.x * this.x) + (this.y * this.y));
  }
};

pointA.distanceToOrigin();      // 50
pointA.onXAxis();               // false
pointA.onYAxis();               // false
```
Literal object creation is useful when all we need is one object.

If we need many points, we might like to:
* be able to have their own **states**, represented by the x and y values;
* share the `distanceToOrigin`, `onXAxis`, and `onYAxis` **behaviors**, because they work the same way for all points on the coordinate plane.

### The Pseudo-classical Pattern
It is a combination of the constructor pattern and the prototype pattern.

Use constructor to set object states and put shared methods on the constructor function's prototype.
```javascript
var Point = function(x, y) {            // capitalized constructor name as a convention
  this.x = x || 0;                      // initialize states with arguments
  this.y = y || 0;                      // 0 as default value
};

Point.prototype.onXAxis = function() {  // shared behaviors added to constructor's prototype property
  return this.y === 0;
}

Point.prototype.onYAxis = function() {  // these methods are added one by one
  return this.x === 0;
}

Point.prototype.distanceToOrigin = function() {
  return Math.sqrt((this.x * this.x) + (this.y * this.y));
}

var pointA = new Point(30, 40);     // use new to create objects
var pointB = new Point(20);

pointA instanceof Point;            // use instanceof to check type
pointB instanceof Point;

pointA.distanceToOrigin();          // 50
pointB.onXAxis();                   // true
```

### The OLOO Pattern
"Object Linking to Other Objects"

Define the shared behaviors on a prototype object, then use `Object.create()` to create objects that inherit directly from that object, without going through the roundabout way that involve "constructors and their prototype properties" at all.

```javascript
var Point = {                       // capitalized name for the prototype as a convention
  x: 0,                             // default value defined on the prototype
  y: 0,

  onXAxis: function() {            // shared methods defined on the prototype
    return this.y === 0;
  },

  onYAxis: function() {
    return this.x === 0;
  },

  distanceToOrigin:  function() {
    return Math.sqrt((this.x * this.x) + (this.y * this.y));
  },

  init: function(x, y) {          // optional init method to set states
    this.x = x;
    this.y = y;
    return this;
  }
};

var pointA = Object.create(Point).init(30, 40);
var pointB = Object.create(Point);

Point.isPrototypeOf(pointA);        // use isPrototypeOf to check type
Point.isPrototypeOf(pointB);

pointA.distanceToOrigin();          // 50
pointB.onXAxis();                   // true
```

### Further Reading
[Object Oriented JavaScript Pattern Comparison](https://john-dugan.com/object-oriented-javascript-pattern-comparison/)

## More Methods on the Object Constructor

[For Reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object)

### Object.create() and Object.getPrototypeOf()

Use this in a chain-like way to mimic classical inheritance.
```javascript
Object.getPrototypeOf([]) === Array.Prototype;        // true

function NewArray() {}
NewArray.prototype = Object.create(Object.getPrototypeOf([]));
```
Now the prototype of `NewArray` is the prototype of `Array`.

```javascript
NewArray.prototype.first = function() {
  return this[0];
}
```
Add a method on `NewArray.prototype`. Now it has the special ability to return the first element in the array.

### Object.defineProperties()
Want a constructor to return a new object with a log function that can't be modified. Not possible with a normal constructor. Use `defineProperties` method on `Object` to make it happen.

```javascript
var obj = {
  name: 'Obj'
};

Object.defineProperties(obj, {
  age: {
    value: 30,
    writable: false
  }
});

console.log(obj.age);   // 30
obj.age = 32;
console.log(obj.age);   // 30
```

```javascript
function newPerson(name) {
  return Object.defineProperties({ name: name }, {
    log: {
      value: function() {
        console.log(this.name);
      },
      writable: false
    }
  });
}

var me = newPerson('Shane Riley');
me.log();       // Shane Riley
me.log = function() { console.log("Amanda Rose"); };
me.log();       // Shane Riley
```

### Object.freeze()

Use this to make all properties immutable. This prevents any property values that are not objects from being changed or deleted.
```javascript
var frozen = {
  integer: 4,
  string: 'String',
  array: [1, 2, 3],
  object: {
    foo: 'bar'
  },
  func: function() {
    console.log('I\'m frozen');
  }
};

Object.freeze(frozen);
frozen.integer = 8;
frozen.string = 'Number';
frozen.array.pop();
frozen.object.foo = 'baz';
frozen.func = function() {
  console.log('I\'m not really frozen');
};

console.log(frozen.integer);            // 4
console.log(frozen.string);             // String
console.log(frozen.array);              // [1, 2] -> changed
console.log(frozen.object.foo);         // baz -> changed
frozen.func();                          // I'm frozen
```

## Summary

* Factory functions (also known as the Factory Object Creation Pattern) instantiate and return a new object in the function body. They allow us to create new objects based on a pre-defined template and have two major downsides:
  * There is no way to tell based on a returned object itself whether the object was created by a factory function.
  * All objects created by factory functions that share behavior have an owned copy or copies of the methods, which can be redundant.


* Constructor functions are meant to be invoked with the new operator. They instantiate a new object behind the scenes and allow the developer to manipulate it using the this keyword. A typical constructor is used with the following pattern:
  1. The constructor is invoked with `new`
  2. A new object is created by the JS runtime
  3. The new object is assigned to `this` inside the function body
  4. The code inside the function is executed
  5. `this` is returned unless there's an explicit return.


* Every object has a `__proto__` property that points to a special object, the object's prototype, which is used to lookup properties that don't exist on the object itself.
* `Object.create` returns a new object with the argument object as its prototype.
* `Object.getPrototypeOf` and `obj.isPrototypeOf` can be used to check for prototype relationships between objects.


* The prototype chain property lookup is the basis for "prototypal inheritance", or property sharing through the prototype chain. Downstream objects "inherit" properties and behaviors from upstream objects, or, put differently, downstream objects can "delegate" properties or behaviors upstream.
  * A downstream object overwrites an inherited property if it has a same-named property on itself.
  * `Object.getOwnPropertyNames` and `obj.hasOwnProperty` can be used test whether a given property is owned by an object.


* Every function has a `prototype` property that points to an object with a `constructor` property, that points back to the function itself. If the function is used as a constructor, then the returned object's `__proto__` will be set to the constructor's `prototype` property. This behavior allows us to set properties on the constructor's `prototype` object that will be shared by all objects returned by it. This is called the "Prototype Pattern" of object creation.
* The Pseudo Classical Pattern of object creation generates objects using a constructor function that defines state, and then defines shared behaviors on the constructor's `prototype`.
* The Objects Linking to Other Objects (OLOO) pattern of object creation uses a template object and `Object.create` to generate objects with shared behavior.
* An optional `init` method on the template object is used to define unique state on the returned objects.
