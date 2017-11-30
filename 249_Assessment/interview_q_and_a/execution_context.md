# What is execution context, can it be changed, and if so, how?

Execution context is the context in which a function/method is executed. The context is accessible inside the executed function/method; it is an object representing all the properties and methods accessible in the created closure that was defined at function declaration.

Example:
```javascript
var id = 6789;

var account = {
  id: 1234,
  deposit: function() {
    return this.id;
  }
}

var otherAccount = {
  id: 5555,
  deposit: function() {
    return "not the id";
  }
}

console.log(this.id);             // 6789
console.log(account.deposit());   // 1234
```

`this` in the method call on the last line is the object `account`, meaning `this.id` is equivalent to `account.id`.

The execution context can be explicitly changed using `call`, `apply`, and `bind`.

Example:
```javascript
// ... the previous code ...

console.log(otherAccount.deposit())
console.log(account.deposit.call(otherAccount));  // 5555;
```

The execution context of the `deposit` method of the `account` object was changed from its implicit context of `account` to `otherAccount` by using the function `call`. The `id` of `otherAccount` is logged instead.

`apply` is the same as `call` except arguments are passed into the function as a single array instead of an argument list.

`bind` is a third method used to change the execution context of a function. `bind` differs from `call` and `apply` in that it returns a function with a permanent execution context that can be called later.

Example:
```javascript
// ... the previous code ...

var deposit = account.deposit.bind(otherAccount);

console.log(deposit());                             // 5555
var failedChange = deposit.bind(account);
console.log(failedChange());                        // 5555 (not 1234)
```

As said before, the context of a `bind`ed function cannot be changed.
