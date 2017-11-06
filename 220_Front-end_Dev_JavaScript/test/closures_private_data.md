# Closures and Private Data
* It forces other developers to use the intended interface. Data access is through provided methods.
* Helps protect data integrity. We are forced to use add to add an item which ensures that every addition is logged.
* This can however make extending the code harder.
```javascript

function makeBank() {
  var accounts = [];

  function makeAccount(number) {
    var balance = 0;
    var transactions = [];
    return {
      getBalance: function() {
        return balance;
      },
      deposit: function(amount) {
        balance += amount;
        transactions.push({ type: "deposit", amount: amount });
        return amount;
      },
      withdraw: function(amount) {
        if (amount > balance) {
          amount = balance;
        }

        balance -= amount;
        transactions.push({ type: "withdraw", amount: amount });
        return amount;
      },
      balance: function() {
        return balance;
      },
      number: function() {
        return number;
      },
      transactions: function() {
        return transactions;
      }
    }
  }

  return {
    openAccount: function() {
      var nextId = accounts.length + 101;
      var account = makeAccount(nextId);
      accounts.push(account);
      return account;
    },
    transfer: function(source, destination, amount) {
      return destination.deposit(source.withdraw(amount));
    }
  }
}

var bank = makeBank();
var acc1 = bank.openAccount();
console.log("Balance:", acc1.balance()); // 0
console.log("Deposit 10:", acc1.deposit(10));  // 10
console.log("Balance:", acc1.balance()); // 10
console.log("acc1.balance:", acc1.balance);      // undefined
// console.log(balance);           // Uncaught ReferenceError; balance is not defined
console.log("Number:", acc1.number());
console.log("Deposit 10:", acc1.deposit(10));  // 10
console.log("Deposit 10:", acc1.deposit(10));  // 10
console.log("Deposit 10:", acc1.deposit(10));  // 10
console.log("Withdraw 5:", acc1.withdraw(5));  // 5
console.log("Withdraw 5:", acc1.withdraw(5));  // 5
console.log("transactions:", acc1.transactions());
console.log("Balance:", acc1.balance()); // 30


```
`accounts`, `balance`, `number`, and `transactions` can't be accessed directly. They are essentially protected data. It must be accessed using methods of the returned object.

This is because of the closure created when the returned function was returned. This returned function retains a reference to these variables.


**NOTE**: **There is no way to access variables inside a closure from outside the closure.**

### Objects and Private Data
If you want something to be directly accessible, include it has a property of the return object.
If you want something to be accessible only through methods of the returned object, then include it in the closure.
#### Directly Accessible
```javascript
function makeList() {
  return {
    items: [],
    add: function(item) {
      this.items.push(item);
    }
  }
}

var list = makeList();
list.add("apples");
list.items // ["apples"]   items is accessible
```
#### Accessible Through Methods
```javascript
function makeList() {
  items = [];
  return {
    add: function(item) {
      items.push(item);
    },
    list: function() {
      items.forEach(function(item) {
        console.log(item);
      });
    },
  }
}

var list = makeList();
list.add("apples");
list.items // undefined
list.list(); // ["apples"]
```
