$(function() {
  var $list = $('ul');
  // Compile both templates for use later
  var productsList = Handlebars.compile($('#productsList').html());
  var productTemplate = Handlebars.compile($('#productTemplate').html());

  // Also register the product template as a partial
  Handlebars.registerPartial('productTemplate', $('#productTemplate').html());


  var products = [{
    name: 'Banana',
    quantity: 14,
    price: 0.79
  }, {
    name: 'Apple',
    quantity: 3,
    price: 0.55
  }];

  // Write the current list to the page
  $list.html(productsList({ items: products }));


  // Create a new product
  var newProduct = [
    {
      name: 'Soup',
      quantity: 1,
      price: 1.29
    },
    {
      name: 'Beef',
      quantity: 1,
      price: 1.29
    }
  ]

  // Render the new product with the product template
  $list.append(productsList({items: newProduct}));

  setTimeout(function() {
    $list.append(productsList({items: newProduct}));
  }, 2000)
});
