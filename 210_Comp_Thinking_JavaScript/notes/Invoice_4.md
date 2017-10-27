# Invoice

Refactor so this works with any number of line items.
```javascript
function invoiceTotal(amount1, amount2, amount3, amount4) {
  return amount1 + amount2 + amount3 + amount4;
}

invoiceTotal(20, 30, 40, 50);             // 140
```

## ANSWER
```javascript
function invoiceTotal() {
  var total = 0;
  for (var i = 0; i < arguments.length; i += 1) {
    total += arguments[i];
  }
  return total;
}

invoiceTotal(20, 30, 40, 50);             // 140
invoiceTotal(20, 30, 40, 50, 40, 40);     // 220
```