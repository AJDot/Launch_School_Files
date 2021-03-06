# Object Creation Patterns

## Prototypal Inheritance (aka Behavior Delegation)
1. Create an object intended to be the prototype of many objects.
2. Create new objects using `Object.create(prototype)`.

Now each object created using step 2 will have all the properties and functions defined on the object designed in step 1.

Properties can be overridden on newly created objects to make each one unique.

Advantages:
* New objects can be created easily using the prototype. The properties from the prototype are not duplicated to every object but remain on the prototype. The prototype chain is what allows each newly created object to use those properties on the prototype.

Because of this delegation, `Object.getOwnPropertyNames` and `hasOwnProperty` can be used to determine if the property is on that immediate object (or else it's located somewhere up the prototype chain).

---

#### Prototypal Inheritance and Behavior Delegation
```javascript
function log(text, code) { console.log(text, " => ", code); }

var account = {
  balance: 0,
  interest: .01,

  getBalance: function() {
    console.log("Balance: $" + this.balance);
    return this.balance;
  },

  deposit: function(amount) {
    console.log('$' + amount + " deposited.");
    this.balance += amount;
    return amount;
  },

  getInterest: function() {
    console.log("Interest: " + this.interest * 100 + "%");
    return this.interest;
  }
}


var checking = Object.create(account);
checking.getBalance();
checking.deposit(30);
checking.getBalance();
checking.getInterest();

console.log(' ');

var savings = Object.create(account);
savings.getBalance();
savings.deposit(100);
savings.getBalance();
savings.interest = .08;
savings.getInterest();

account.withdraw = function(amount) {
  if (this.balance < amount) {
    amount = this.balance;
  }

  this.balance -= amount;
  console.log('$' + amount + " withdrawn.");
  return amount;
}

console.log(' ');
console.log('withdraw method created on prototype object `account`.')

checking.withdraw(12);
checking.getBalance();

savings.withdraw(75);
savings.getBalance();
```

---

To create a (shallow) copy of an object, both the properties on the original object and the prototype of the original object must be copied to the new object.
```javascript
function shallowCopy(object) {
  // makes the prototype the same as the argument object
  // this gives the copy the same chain to lookup
  var result = Object.create(Object.getPrototypeOf(object));

  // copies all the properties on the argument object
  for (var prop in object) {
    if (Object.prototype.hasOwnProperty.call(object, prop)) {
      result[prop] = object[prop];
    }
  }

  return result;
}
```

## Pseudo-classical Pattern
A combination of the constructor pattern and the prototype pattern. Constructor is used set object states and shared methods are put on the constructor function's prototype.
```javascript
var Account = function (name) {
  this.name = name;
  this.id = 1293;   // made unique through other methods
};

Account.prototype.getBalance = function() {
  // code..
}

Account.prototype.deposit = function() {
  // code..
}

var acc = new Account("checking"); // use new to create objects

acc instanceof Account; // use instanceof to check type
```

## OLOO Pattern
Objects Linking to Other Objects.

Define shared behaviors on the prototype object. Use an optional `init` method to set unique state.
```javascript
var Account = {
  name: '',
  id: 1293,   // made unique through other methods
  getBalance: function() {
  // code..
  },
  deposit: function() {
  // code..
  },
  init: function(name, id) {
    this.name = name;
    this.id = id;
  },
}

// use Object.create to create new object
var acc = Object.create(Account).init("checking", 1293);

Account.isPrototypeOf(acc); // use isPrototypeOf to check type
```
