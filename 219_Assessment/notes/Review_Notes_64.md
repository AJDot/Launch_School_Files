# Review Notes
## Data Types
* number
* boolean
* string
* null
* undefined

You cannot change a primitive value once you create it. When you reassign a variable, the original value does not change; instead, the new value is assigned to the variable.
Strings can be both primitive values and compound values. JavaScript typically stores strings as primitive values but when String.prototype methods are called, JS creates a temporary String object. `new String()` can be used to create one explicitly.

variable declaration is a statement. variable assignment is an expression.

Concatenation is always performed when `+` is used with a string operand; otherwise, it performs addition.

## Implicit Primitive Type Coercions
### `+`
unary `+` tries to convert values into number:
```javascript
+(null) // 0
```

plus operator `+` means addition for numbers and concatenation for strings. If types are mixed, JS tries to convert the other operand to a string
```javascript
1 + true // 2
```

### other arithmetic operators
are only defined for numbers so JS tries to coerce operands to numbers

### Relational Operators
`<`, `>`, `<=`, `>=`, are defined for numbers and strings. In general, JS tries to coerce the operation into a number comparison unless both are strings.

### Equality
#### Non-strict `==`
Set of complex rules for coercion
#### Strict `===`
No coercion performed

## Truthy and Falsy
6 values are falsy
* `false`
* `null`
* `0`
* `undefined`
* `NaN`
Everything else is a truthy value