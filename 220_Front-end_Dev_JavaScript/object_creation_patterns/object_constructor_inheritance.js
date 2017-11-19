function Vehicle() {
  if (!(this instanceof Vehicle)) {
    return new Vehicle();
  }
  return this;
}

Vehicle.prototype = {
  doors: 4,
  wheels: 4
}

var sedan = Vehicle();
var coupe = new Vehicle();

coupe.doors = 2;
console.log('sedan doors:', sedan.hasOwnProperty('doors')); // false
console.log('coupe doors:', coupe.hasOwnProperty('doors')); // true

function Coupe() {
  if (!(this instanceof Vehicle)) {
    return new Coupe();
  }
  return this;
}
Coupe.prototype = new Vehicle();
Coupe.prototype.doors = 2;

var crx = new Coupe();
console.log(crx.doors); // 2
console.log(crx instanceof Vehicle);
console.log(crx instanceof Coupe);

function Motorcycle() {
  var o = this;
  if (!(o instanceof Vehicle)) {
    return new Motorcycle();
  }
  o.door = 0;
  o.wheels = 2;
  return o;
}

Motorcycle.prototype = new Vehicle();

var monster = new Motorcycle();

function Sedan() {

}

Sedan.prototype = Object.create(Vehicle.prototype);
var lesabre;
console.log(lesabre instanceof Sedan);
console.log(lesabre instanceof Vehicle);
