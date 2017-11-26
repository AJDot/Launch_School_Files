var inventory;

(function() {
  inventory = {
    collection: [],
    lastId: 0,
    setDate: function() {
      var date = new Date();
      $('#order_date').text(date.toUTCString());
    },
    cacheTemplate: function() {
      var $inventoryItem = $('#inventory_item');
      this.template = Handlebars.compile($inventoryItem.html()),
      $inventoryItem.remove();
    },
    add: function() {
      this.lastId++;
      var item = {
        id: this.lastId,
        name: "",
        stockNumber: "",
        quantity: 1
      };
      this.collection.push(item);

      return item;
    },
    remove: function(id) {
      this.collection = this.collection.filter(function(item) {
        return item.id !== id;
      });
    },
    get: function(id) {
      return this.collection.find(function(item) {
        return item.id === id;
      });
    },
    update: function($item) {
      var id = this.findId($item);
      var item = this.get(id);
      item.name = $item.find("[name^='item_name']").val();
      item.stockNumber = $item.find("[name^='item_stock_number']").val();
      item.quantity = $item.find("[name^='item_quantity']").val();
    },
    newItem: function(e) {
      e.preventDefault();
      var item = this.add();
      $('#inventory').append(this.template({ ID: item.id }));
    },
    findParent: function(e) {
      return $(e.target).closest("tr");
    },
    findId: function($item) {
      return +$item.find("input[type=hidden]").val();
    },
    deleteItem: function(e) {
      e.preventDefault();
      var $item = this.findParent(e).remove();
      this.remove(this.findId($item));
    },
    updateItem: function(e) {
      var $item = this.findParent(e);

      this.update($item);
    },
    bind: function() {
      $('#add_item').on('click', this.newItem.bind(this));
      $('#inventory').on('click', 'a.delete', this.deleteItem.bind(this));
      $('#inventory').on('blur', ':input', this.updateItem.bind(this));
    },
    init: function() {
      this.setDate();
      this.cacheTemplate();
      this.bind();
    }
  };
})();

$(inventory.init.bind(inventory));
