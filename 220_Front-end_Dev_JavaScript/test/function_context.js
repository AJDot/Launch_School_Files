var grades = [50, 60, 70, 80, 90, 100];

function average() {
  var total = 0;
  for (var i = 0; i < this.length; i++) {
    total += this[i];
  }

  return total / this.length;
}

// Here the execution context is the global object
// The global object does not have a grades property
console.log(average(grades));  // NaN

// Must use call or apply to explicitly make grades the execution context.
console.log(average.call(grades));

// can bind it forever
var averageGrade = average.bind(grades);
console.log("averageGrade() ->", averageGrade());
grades.push(40);
console.log("After .push(40) onto grades:", "averageGrade() ->", averageGrade());
