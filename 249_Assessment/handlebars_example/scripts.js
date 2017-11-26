var rows = Handlebars.compile($('#rows').html());
var rowPartial = Handlebars.registerPartial('row', $('#row').html());
var typesPartial = Handlebars.registerPartial('types', $('#types').html());
var typePartial = Handlebars.registerPartial('type', $('#type').html());

var items = [
  {
    name: 'Apple',
    quantity: 1,
    types: ["Gala", "Red Delicious", "Honey Crisp"]
  },
  {
    name: 'Banana',
    quantity: 2
  },
  {
    name: 'Cow',
    quantity: 3,
    types: ["White", "Brown"]
  },
  {
    name: 'Duck',
    quantity: 4,
    alert: 'Super cheap!',
  },
  {
    name: 'Fritos',
    quantity: 5,
    alert: "Best with chili!"
  },
  {
    name: 'Green Bean',
    quantity: 6
  },
];

$('ul').append(rows({ items: items }));
