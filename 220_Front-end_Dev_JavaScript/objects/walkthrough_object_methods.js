var me = {
  firstName: 'Alex',
  lastName: 'Henegar',
};

// OR

var me = {};
me.firstName = 'Alex';
me.lastName = 'Henegar';

function fullName(person) {
  console.log(person.firstName + ' ' + person.lastName);
}

fullName(me);

var friend = {
  firstName: 'John',
  lastName: 'Smith'
};

var mother = {
  firstName: 'Amber',
  lastName: 'Doe'
};

var father = {
  firstName: 'Shane',
  lastName: 'Doe'
};

var people = [];
people.push(me);
people.push(friend);
people.push(mother);
people.push(father);

function rollCall(collection) {
  for (var i = 0, length = collection.length; i < length; i++) {
    fullName(collection[i]);
  }
}

// OR

function rollCall(collection) {
  collection.forEach(fullName);
}
console.log(' ');
rollCall(people);

// Package it all together in an object

var people = {
  collection: [],
  lastIndex: 0,
  fullName: function(person) {
    console.log(person.firstName + ' ' + person.lastName);
  },
  rollCall: function() {
    this.collection.forEach(this.fullName);
  },
  add: function(person) {
    if (this.isInvalidPerson(person)) {
      return;
    }

    this.lastIndex += 1;
    person.id = this.lastIndex;
    this.collection.push(person);
  },
  getIndex: function(person) {
    var index = -1;
    this.collection.forEach(function(comparator, i) {
      if (comparator.id === person.id) {
        index = i;
      }
    });

    return index;
  },
  isInvalidPerson: function(person) {
    return typeof person.firstName !== 'string' || typeof person.lastName !== 'string';
  },
  remove: function(person) {
    if (this.isInvalidPerson(person)) {
      return;
    }

    var index = this.getIndex(person);
    if (index === -1) {
      return;
    }

    this.collection.splice(index, 1);
  },
  get: function(person) {
    if (this.isInvalidPerson(person)) {
      return;
    }

    return this.collection[this.getIndex(person)];
  },
  update: function(person) {
    if (this.isInvalidPerson(person)) {
      return;
    }

    var existingPersonId = this.getIndex(person);
    if (existingPersonId === -1) {
      this.add(person);
    } else {
      this.collection[existingPersonId] = person;
    }
  },
};
console.log(' ');
people.rollCall();

var sister = {
  firstName: 'Tracy',
  lastName: 'Smith'
};

people.add(me);
people.add(friend);
people.add(mother);
people.add(father);
people.add(sister);
console.log(' ');
people.rollCall();

console.log(' ');
people.remove(mother);

console.log(' ');
people.remove({ firstName: 'John', lastName: 'Smith' });
people.rollCall();

console.log(people.getIndex(friend)); // 1
people.remove(friend);
console.log(people.getIndex(friend)); // -1
console.log(people.get(sister));
console.log(people.get(me));
var newMe = {
  id: 1,
  firstName: 'Bill',
  lastName: 'Pullman',
}
people.update(newMe);
console.log(people.get({id: 1}));
