var foo = {
  a: 1,
  b: 2
};

// foo becomes the prototype of bar
// and bar is a clean, new object with no properties or methods
var bar = Object.create(foo);

console.log(bar.__proto__ === foo);
console.log(Object.getPrototypeOf(bar) === foo);

// **************************************************

var prot = {}

// Set prot as prototype of a new object foo
var foo = Object.create(prot);

console.log(Object.getPrototypeOf(foo) === prot);
console.log(prot.isPrototypeOf(foo));
console.log(foo.__proto__ === prot);


// Return object where property is defined
function getDefiningObject(object, propKey) {
  while (object && !object.hasOwnProperty(propKey)) {
    object = Object.getPrototypeOf(object)
  }

  return object
}

var foo = {
  a: 1,
  b: 2
};

var bar = Object.create(foo);
var baz = Object.create(bar);
var qux = Object.create(baz);

bar.c = 3;

console.log(getDefiningObject(qux, 'c') === bar);     // true
console.log(getDefiningObject(qux, 'e'));             // null
