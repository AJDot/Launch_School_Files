# How do you deal with context loss?

---

If context is lost because a method was taken out of its object then you can hard bind it to the object using `bind`.

```javascript
var account = {
  balance: 0,
  deposit: function(amount) {
    this.balance += amount;
    return amount;
  }
}

var depositIntoAccount = account.deposit.bind(account);
console.log(account.balance);
depositIntoAccount(29);
console.log(account.balance);
```

Even though `depositIntoAccount` was invoked in the global context, it was hard binded to `account` so that will always be its execution context.

---

If an internal function loses execution context there are a few ways to remedy it.

```javascript
// Lost Context
var account = {
  balance: 0,
  deposit: function(amount) {
    function add() {
      this.balance += amount
    }
    add();
  }
}
```
1. Preserve the context by storing it in a local variable in lexical scope.
```javascript
// 1
var account = {
  balance: 0,
  deposit: function(amount) {
    var self = this;
    function add() {
      self.balance += amount
    }
    add();
  }
}
```
2. Pass the context to internal functions using `call` or `apply`.
```javascript
// 2
var account = {
  balance: 0,
  deposit: function(amount) {
    var self = this;
    function add() {
      self.balance += amount;
    }
    add();
  }
}
```
3. Hard bind the internal function using `bind`.
```javascript
// 3
var account = {
  balance: 0,
  deposit: function(amount) {
    var add = function() {
      this.balance += amount
    }.bind(this);
    add();
  }
}
```

---

If a function passed into another function as an argument loses surround context then use the same 3 methods described above to restore it.
