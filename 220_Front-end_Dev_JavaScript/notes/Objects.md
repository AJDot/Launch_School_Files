# Objects

<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Objects](#objects)
  * [Objects and Methods](#objects-and-methods)
    * [Function and Method Invocation](#function-and-method-invocation)
    * [`this` during Method Invocation](#this-during-method-invocation)
  * [Mutating Objects](#mutating-objects)
  * [Functions as Object Factories](#functions-as-object-factories)
  * [Object Orientation](#object-orientation)
      * [Local Variables and Functions Solution](#local-variables-and-functions-solution)
      * [Object-oriented Solution](#object-oriented-solution)
  * [Summary](#summary)

<!-- tocstop -->
## Objects and Methods
Objects can contain:
* properties
* methods - Functions with a receiver

Refer to these as "function invocation" and "method invocation".

### Function and Method Invocation
```javascript
var greeter = {
  morning: function() {
  }
};

function evening() {
}

// Method invocation
greeter.morning()   // greeter is the receiver/calling object; morning() is a method

// Function invocation
evening()           // there is no receiver; evening() is a function
```

One function object can use both invocations:
```javascript
// Method invocation: executing a method
greeter.morning();

// Create a variable which points at the greeter.morning method
functionGreeter = greeter.morning;  // return [Function: morning]

// Function invocation: executing a function
functionGreeter();
```

### `this` during Method Invocation
`this` is a reference to the Object itself.
```javascript
var counter = {
  count: 0,
  advance: function() {
    this.count += 1;
  }
};

counter;                // { count: 0, advance: [Function] }

counter.advance();
counter;                // { count: 1, advance: [Function] }

counter.advance();
counter.advance();

counter;                // { count: 3, advance: [Function] }
```
Here, `this` is the object that contains the object `counter`

## Mutating Objects
Primitive types are immutable but most JavaScript Objects are **mutable**.

Functions can alter the content of Objects passed in as arguments. **Any other code that references that object sees those same changes.**

```javascript
function increment(thing) {
  thing.count += 1;
  console.log(thing.count);
}
```

```
> var counter = { count: 0 };
> counter
= { count: 0 }
> increment(counter);
1
> counter
= { count: 1 }
```

This code does not reassign `thing` (which is the same as `counter`), but instead modifies a property of the Object: `count`. It alters the state of the object, but it *does not create a new object*. `thing` and `counter` continue to point to the same Object.


## Functions as Object Factories
Objects are really useful when more than one instance of a given Object type are used. Objects are a useful organization of related data and behavior.
```javascript
// All cars start out not moving, and sedans
// can accelerate about 8 miles per hour per second (mph/s).
var sedan = {
  speed: 0,
  rate: 8,
  // To accelerate, add the rate of acceleration
  // to the current speed.
  accelerate: function() {
    this.speed += this.rate;
  },
};
```
```
> sedan;
= Object {speed: 0, rate: 8}
> sedan.accelerate();
> sedan;
= Object {speed: 8, rate: 8}
```

If we need another car we could simply copy the code and interact with them independently. However this is a lot of code duplication. To fix this, **move the object similarities to one location and set the difference when individual objects are defined.**

```
> var sedan = makeCar(8);
> sedan.accelerate();
> sedan.speed;
= 8

> var coupe = makeCar(12);
> coupe.accelerate();
> coupe.speed;
= 12
```

```javascript
function makeCar(accelRate, brakeRate) {
  return {
    speed: 0,
    accelRate: accelRate,
    brakeRate: brakeRate,
    accelerate: function() {
      this.speed += this.accelRate;
    },
    brake: function() {
      this.speed -= brakeRate;
      if (this.speed < 0) { this.speed = 0; }
    },
  }
}

var hatchback = makeCar(8, 6);
```

## Object Orientation
> Object-oriented programming is a pattern that uses objects as the basic building blocks of a program instead of local variables andn functions.
> Compare the object-oriented code to the code with which we began. The object-based code is much easier to understand; the relationship between it and the data is readily evident.

#### Local Variables and Functions Solution
```javascript
var smallCarFuel = 7.8;
var smallCarMpg = 37;

var largeCarFuel = 9.4;
var largeCarMpg = 29;

var truckFuel = 14.3;
var truckMpg = 23;

function vehicleRange(fuel, mpg) {
  return fuel * mpg;
}

vehicleRange(smallCarFuel, smallCarMpg); // => 288.6
vehicleRange(largeCarFuel, largeCarMpg); // => 272.6
vehicleRange(truckFuel, truckMpg);       // => 328.9
```

#### Object-oriented Solution
```javascript
function makeVehicle(fuel, mpg) {
  return {
    fuel: fuel,
    mpg: mpg,
    range: function() {
      return this.fuel * this.mpg;
    }
  };
}

var smallCar = makeVehicle(7.8, 37);
smallCar.range();   // => 288.6

var largeCar = makeVehicle(9.4, 29);
largeCar.range();   // => 272.6

var truck = makeVehicle(14.3, 23);
truck.range();      // => 328.9
```

Here are some questions that are easier to answer with the object-oriented code:
1. What are the important concepts in the program?
2. What are the properties of a vehicle?
3. How do we create vehicles?
4. What operations can I perform on a vehicle?
5. Where should we add new properties and methods?

Objects:
* organize related data and code together.
* are useful when a program needs more than one instance of something.
* become more useful as the codebase size increases.

## Summary
> * **Object-oriented programming** is a pattern that uses objectst to organize code instead of procedures or Functions. Objects can also contain data or state.
> * You call a property whose value assigned to it is a function a **method**.
> * You can add methods to an object at any time, as with any other property.
> * Objects ecome more useful as projects become larger and more complicated.
