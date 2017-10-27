# Objects
## Introduction to Objects
JavaScript is an *object-oriented* language. Typically data values and the functions that operate on those values are part of the same object.

### Standard Built-in Objects
Includes: `String`, `Array`, `Object`, `Math`, `Date`, and others.

For strings, JavaScript has both primitive and object Strings. However, when a method is applied to a primitive, JS automatically converts it to an object.
```javascript
typeof a;                         // "string", this is a primitive string value

var stringObject = new String(a); // Convert the primitive to an object
typeof stringObject;              // "object", this is a String object

stringObject.toUpperCase();       // Call the method on the object: "HI"
```
For the most part, you can treat primitives like objects and things will just work.

### Creating Custom Objects

Using literal notation:
```javascript
var colors = {
};                                // undefined (var always return undefined)

```


### Properties

Objects hold both data and behavior. Data is the named items and their values; the values are the attributes of the object. A name (or key) and a value pair are called **properties**.

Use dot notation followed by a property name to access its value.
```javascript
animal.length;          // 6

```

Set a new value with assignment
```javascript
var count = [0, 1, 2, 3, 4];
count.length = 2;

var colors = {
};

```

### Methods
Functions are the behavior of objects. When they are part of an object, we call them **methods**.

#### NOTE ON STYLE
Custom objects using object literal notation always use a trailing comma when written across multiple lines. So even the last property or method ends with a comma.

* If code is reorganized or repositioned, no worrying about adding in or deleting the trailing comma.
* Without a trailing comma, adding a property shows up as *2 lines of changes* when you run `git diff`. The presence of the new comma creates the second change.
* No trailing comma is needed for a one-line literal.

## Object Properties
### Property Names and Values
A property name can be any valid string. A property value can be any valid expression.
```javascript
var object = {
  a: 1,                           // a is a string with quotes omitted
  true: true,                     // property name is implicitly converted to string "true"
  b: {                            // object as property value
  },
  c: function() {                 // function expression as property value
    return 2;
  },
};
```

### Accessing Property Values
Use "dot notation" or "bracket notation":

```javascript
var object = {
}

object.a;                       // "hello", dot notation
object.c;                       // undefined when property is not defined
```

* Use bracket notation when a property name would be invalid (has spaces).
* Bracket notation can take expressions
* Dot notation can be chained

RECOMMENDATION: JavaScript style guides usually recommend using dot notation when possible.

### Adding and Updating Properties

Use "dot notation" or "bracket notation" and assign a new value to the result:
```javascript
var object = {};              // empty object

object.a;                     // "foo"


object;                       // {a: "foo", "a name": "hello"}
```


Use the `delete` reserved word to delete properties from objects:
```javascript
var foo = {
},

delete foo.a;
foo;                // {b: "world}
```

## Stepping through Object Properties
Objects are a collection.

To perform an action on each element, use a `for...in` loop:
```javascript
var nick;

var nicknames = {
};

for (nick in nicknames) {
  console.log(nick);              // property name
  console.log(nicknames[nick]);   // property value
}


// logs on the console:
joseph
Joey
margaret
Maggie
```

Retrieve all property names with `Object.keys()`
```javascript
```

## Arrays and Objects
When should you use one over the other?

### Array
If the data is more like a list, usually all of the same type, use an array:
```javascript
[1, 2, 3];
```

Most common interactions with Arrays:
* adding elements
* retrieving elements
* modifying elements
* removing elements
* iterating over elements

Usually a process on every element is performed.

**Use an `Array` if you need to maintain data in a specific order.**

### Object
Use an object if the data is more like an entity with many parts:
```javascript
{
  age: 30,
  married: false,
}
```

Objects usually involved "keyed" access to add, retrieve, modify, or delete a specific item. An object may be referred to as an "associative array".

**Use an `Object` if you need to access values based on the names of those values.**

### Arrays are Objects
Arrays are *actually* objects:
```javascript

// is equivalent to:

var a = {
};

Object.keys(a);           // ["0", "1"], the keys of the object
```
The indices of the array are the keys of the object.
**There are slight nuances between the two though.**

### Arrays and the Length Property

* Always a non-negative integer less than 2<sup>32</sup> (roughly 4.2 billion).
* value of `length` property is one greater than the largest **array index** in the Array.
* `length` can be set explicitly by the developer.

When a property name is not a non-negative integer, it is not counted as an array index. i.e. `length` will not count this property:
```javascript
var myArray = [];


Object.keys(myArray).length           // returns 3 (foo is a key)
myArray.length;                       // returns 2 (foo is not an index)
```

* Only non-negative integer property names are considered **elements** of the array. All other property name are not considered elements.
* `Array.prototye.indexOf()` returns `-1` if it is not an element of the array.
* `length` depeneds on the largest array index.
* Logging an array will include all indexed values *AND* every "key:value" pair not considered as an index.

Additionally:
* If `length` is set to a value smaller than the current largest array index, those higher elements will get deleted.
* If `length` is set to a larger value than the current largest array index, it will pad the additional elements as `undefined`.

### Using Object Operations with Arrays
Arrays are objects, so object operations can be used such as `in` and `delete`.
```javascript
// check if an index exists
0 in [];      // false
0 in [1];     // true
```
However, compare to the length of the array instead.
```javascript
var numbers = [4, 8, 1, 3];
2 < numbers.length;         // true
```


**NOTE**: Properties of arrays that are not array indexes **will not be processed by the built-in array methods**.

## Mutability of Values and Objects
The difference between primitive types (numbers, strings, booleans, `null`, `undefined`) and object *mutability*.

* *primitive* values are immutable. Operations on these values return a new value of the same type.
* Objects are *mutable*: you can modify them without changing their identity.

## Pure Functions and Side Effects

**Function Side effects**: directly modify variables defined in outer scopes or mutate Objects passed to the Function as arguments.

**Pure Function**: a Function with no side effects. They rely on their arguments to determine their return value. Given the same arguments, they will always evaluate to the same result.

NOTE: Pure Functions always return a value. A Function without side effects or a return values can really do anything.

### Pure Function Return Value vs Non-Pure Function Side Effects

You must choose whether you want a pure function or you want side effects. If a function is used for its return value it will likely be part of an expression or an assignment.
```javascript
function joinString(a, b, c) {
  return a.concat(b, c);
}

console.log(result);
```

Most developers expect line 5 to have no side effects since the return value is used. Most functions do one or the other.

If you use a function for a side effect, pass in the variable(s) you will mutate as argument(s):
```javascript

function removeElement(array, element) {
  for (var i = 0; i < array.length; i++) {
    if (array[i] === element) {
      array.splice(i, 1);
    }
  }
}

friends;                               // ["Joe", "Mary"]
```

**NOTE**: Functions that cause unexpected side effects are a major source of bugs.


## Working with the Function Arguments Object
To circumvent JS ignoring excess arguments, utilize the `arguments` object. It is an *array-like* local variable available inside all Functions. It contains all arguments passed to the Function.

```javascript
function logArgs(a) {
  console.log(arguments[0]);
  console.log(arguments[1]);
  console.log(arguments.length);
}

// logs:
1
a
2
```

If needed, an array can be made from the arguments:
```javascript
var args = Array.prototype.slice.call(arguments);
```

### Functions that Accept Any Number of Arguments
A sum function would be a good candidate:
```javascript
function sum() {
  var result = 0
  for (var i = 0; i < arguments.length; i++) {
    result += arguments[i]; 
  }
   return result;
}
```
**RECOMMENDATION**: Only use this when you really need an arbitrary number of arguments. Intention and readability are lowered with this method.