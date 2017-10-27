function setPrice(product, price) {
  if (price >= 0) {
    product.price = price;
  } else {
    alert('Invalid price!');
  }
}

function describeProduct(product) {
  console.log('Name: ' + product.name);
  console.log('ID: ' + product.id);
  console.log('Price: $' + product.price);
  console.log('Stock: ' + product.stock);
}

function createProduct(id, name, stock, price) {
  return {
    id: id,
    name: name,
    stock: stock,
    price: price,
    setPrice: function(newPrice) {
      if (newPrice >= 0) {
        this.price = newPrice;
      } else {
        alert('Invalid price!');
      }
    },
    describe: function() {
      console.log('Name: ' + this.name);
      console.log('ID: ' + this.id);
      console.log('Price: $' + this.price);
      console.log('Stock: ' + this.stock);
    },
  }
}

var scissors = createProduct(0, 'Scissors', 8, 10);
var scissors2 = createProduct(0, 'Scissors', 8, 10);
var drill = createProduct(1, 'Cordless Drill', 15, 45);
var saw = createProduct(2, 'Circular Saw', 12, 95);
var hammer = createProduct(3, 'Sledge Hammer', 78, 45);
var boxCutter = createProduct(4, 'Box Cutter', 41, 15);

scissors.describe();
console.log(' ');
drill.describe();
console.log(' ');
saw.describe();
console.log(' ');
hammer.describe();
console.log(' ');
boxCutter.describe();
