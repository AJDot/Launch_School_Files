# Object.create

When `Object.create` is used, a new object is created and the `__proto__` property is set to the object that was passed in.

Example:
```javascript
var account = {
  balance: 0,
}

var checking = Object.create(account);

checking;                         // {}
checking.balance;                 // 0 (but the property is on the prototype)
checking.__proto__ === account;   // true
// OR
Object.getPrototypeOf(checking) === account; // true
account.isPrototypeOf(checking); // true

```
