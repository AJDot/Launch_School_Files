# Practice Problems: Logic and Flow Control
## JavaScript Coding Styles
A style guide typically has two types of rules:
* **Formatting and Aesthetic**: This includes indentation, spacing (where to apply white spaces), single quotes vs double quotes, etc. Consistently formatted code is easier to read, and easier tomaintain.
* **Best Practices**: This includes how to perform type coercions, how to define variables with hoisting rules, etc. Those rules often have opinionated roots, but they attempt to steer ou from the dark alleys and pitfalls of the language by avoiding constructs that cause trouble.

LS recommendeds [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript).


### Spacing

Use soft tabs set to two spaces.
```javascript
// bad
function foo() {
∙∙∙∙var name;
}

// bad
function bar() {
∙var name;
}

// good
function baz() {
∙∙var name;
}
```

Place one space before the leading brace.
```javascript
// bad
function test(){
}

// good
function test() {
}
```

Place one space before the opening parenthesis in control statements (if, while etc.). Place no space between the argument list and the function name in function calls and declarations.

```javascript
// bad
if(isJedi) {
  fight ();
}

// good
if (isJedi) {
  fight();
}

// bad
function fight () {
}

// good
function fight() {
}
```

Set off operators with spaces.

```javascript
// bad
var x=y+5;

// good
var x = y + 5;
```

Do not add spaces inside parentheses.

```javascript
// bad
function bar( foo ) {
  return foo;
}

// good
function bar(foo) {
  return foo;
}

// bad
if ( foo ) {
  console.log(foo);
}

// good
if (foo) {
  console.log(foo);
}
```

Unary special-character operators (e.g., !, ++) must not have spaces between them and their operand.

```javascript
// bad
index ++;

// good
index++;
No preceding spaces before , and ;.

// bad
func(a ,b) ;

// good
func(a, b);
```

No whitespace at the end of line or on blank lines.

```javascript
// bad
func(a, b);∙

// good
func(a, b);
```

The ? and : in a ternary conditional must have space on both sides.

```javascript
// bad

// good
```

Ternaries should not be nested and should generally be single line expressions.

```javascript
// bad
var foo = maybe1 > maybe2

// better

var foo = maybe1 > maybe2
  : maybeNull;

// best

```

Avoid unneeded ternary statements.

```javascript
// bad
var foo = a ? a : b;
var bar = c ? true : false;
var baz = c ? false : true;

// good
var foo = a || b;
var bar = !!c;
var baz = !c;
```

### Blocks

Leave a blank line after blocks and before the next statement.

```javascript
// bad
if (foo) {
  return bar;
}
return baz;

// good
if (foo) {
  return bar;
}

return baz;
```

Do not pad your blocks with blank lines.

```javascript
// bad
function bar() {

  console.log(foo);

}

// also bad
if (baz) {

  console.log(qux);
} else {
  console.log(foo);

}

// good
function bar() {
  console.log(foo);
}

// good
if (baz) {
  console.log(qux);
} else {
  console.log(foo);
}
```

Use braces with all multi-line blocks.

```javascript
// bad
if (test)
  return false;

// good
if (test) return false;

// good
if (test) {
  return false;
}

// bad
function foo() { return false; }

// good
function bar() {
  return false;
}
```


```javascript
// bad
if (test) {
  thing1();
  thing2();
}
else {
  thing3();
}

// good
if (test) {
  thing1();
  thing2();
} else {
  thing3();
}
```

### Semicolons

Use semicolons after every statement, except for statements ending with blocks

```javascript
// bad
var number
number = 5
number = number + 1

// good
var number;
number = 5;
number = number + 1;

// bad
while (number > 0) {
    number--;
};

// good
while (number > 0) {
    number--;
}
```

### Naming Conventions

Use camelCase variable and function names

```javascript
// bad
function call_me() {};

// good
function callMe() {};
```

### Strings


```javascript
// bad
var name = "Capt. Janeway";

// good
```

Use explicit coercion

```javascript
var a = 9;

// bad

// bad
var string = a.toString();

// good
var string = String(a);
```

### Numbers

Use Number for type casting and parseInt always with a radix for parsing strings.

```javascript

// bad
var val = new Number(inputValue);

// bad
var val = +inputValue;

// bad
var val = parseInt(inputValue);

// good
var val = Number(inputValue);

// good
var val = parseInt(inputValue, 10);
```

### Boolean

```javascript
var age = 0;

// bad
var hasAge = new Boolean(age);

// good
var hasAge = Boolean(age);

// best
var hasAge = !!age;
```

### Functions

Never declare a function in a non-function block (if, while, etc).

```javascript
// bad
if (currentUser) {
  function test() {
  }
}

// good
var test;
if (currentUser) {
  test = function() {
  };
}
```

Never name a parameter arguments. This takes precedence over the arguments object that is given to every function scope.

```javascript
// bad
function nope(name, options, arguments) {
  // ...stuff...
}

// good
function yup(name, options, args) {
  // ...stuff...
}
```