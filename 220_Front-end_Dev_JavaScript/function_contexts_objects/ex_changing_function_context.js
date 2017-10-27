var temperatures = [53, 86, 12, 43];

function average(values) {
  var total = 0;
  for (var i = values.length - 1; i >= 0; i--) {
    total += values[i];
  }

  return total / values.length;
}

console.log(average(temperatures));   // 48.5

// To use `this`
var temperatures = [53, 86, 12, 43];

function average() {
  var total = 0;
  for (var i = this.length - 1; i >= 0; i--) {
    total += this[i];
  }

  return total / this.length;
}

console.log(average.call(temperatures));    // 48.5
console.log(average.apply(temperatures));    // 48.5

// We can permanently bind the average function to the temperatures array
var averageTemperature = average.bind(temperatures);

console.log(averageTemperature());

// Or we can change the execution context to that object specifically.
// Since arrays are objects, this works.
temperatures.average = average;
console.log(temperatures.average());
