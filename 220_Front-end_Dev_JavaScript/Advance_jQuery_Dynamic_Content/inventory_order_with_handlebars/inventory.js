// Refactored LS Solution
var inventory;

(function() {
  var template = cacheTemplate();

  function cacheTemplate() {
    var $i_tmpl = $("#inventory_item").remove();
    return Handlebars.compile($i_tmpl.html());
  };

  inventory = {
    last_id: 0,
    collection: [],
    setDate: function() {
      var date = new Date();
      $("#order_date").text(date.toUTCString());
    },
    add: function() {
      this.last_id++;
      var item = {
        id: this.last_id,
        name: "",
        stock_number: "",
        quantity: 1
      };
      this.collection.push(item);

      return item;
    },
    remove: function(idx) {
      this.collection = this.collection.filter(function(item) {
        return item.id !== idx;
      });
    },
    get: function(id) {
      var found_item;

      this.collection.forEach(function(item) {
        if (item.id === id) {
          found_item = item;
          return false;
        }
      });

      return found_item;
    },
    update: function($item) {
      var id = this.findID($item),
          item = this.get(id);

      item.name = $item.find("[name^=item_name]").val();
      item.stock_number = $item.find("[name^=item_stock_number]").val();
      item.quantity = $item.find("[name^=item_quantity]").val();
    },
    newItem: function(e) {
      e.preventDefault();
      var item = this.add();
          $item = template({ id: item.id });

      $("#inventory").append($item);
    },
    findParent: function(e) {
      return $(e.target).closest("tr");
    },
    findID: function($item) {
      return +$item.find("input[type=hidden]").val();
    },
    deleteItem: function(e) {
      e.preventDefault();
      var $item = this.findParent(e).remove();

      this.remove(this.findID($item));
    },
    updateItem: function(e) {
      var $item = this.findParent(e);

      this.update($item);
    },
    bindEvents: function() {
      $("#add_item").on("click", $.proxy(this.newItem, this));
      $("#inventory").on("click", "a.delete", $.proxy(this.deleteItem, this));
      $("#inventory").on("blur", ":input", $.proxy(this.updateItem, this));
    },
    init: function() {
      this.setDate();
      this.bindEvents();
    }
  };
})();

$(inventory.init.bind(inventory));




// LS SOLUTION
// var inventory;
//
// (function() {
//   inventory = {
//     collection: [],
//     lastId: 0,
//     setDate: function() {
//       var date = new Date();
//       $('#order_date').text(date.toUTCString());
//     },
//     cacheTemplate: function() {
//       var $i_tmpl = $("#inventory_item").remove();
//       this.template = $i_tmpl.html();
//     },
//     add: function() {
//       this.lastId++;
//       var item = {
//         id: this.lastId,
//         name: "",
//         stockNumber: "",
//         quantity: 1,
//       };
//       this.collection.push(item);
//
//       return item;
//     },
//     remove: function(idx) {
//       idx = +idx;
//       this.collection = this.collection.filter(function(item) {
//         return item.id !== idx;
//       });
//     },
//     get: function(id) {
//       var foundItem;
//
//       this.collection.forEach(function(item) {
//         if (item.id === id) {
//           foundItem = item;
//           return false;
//         }
//       });
//
//       return foundItem;
//     },
//     update: function($item) {
//       var id = this.findID($item);
//       var item = this.get(id);
//
//       item.name = $item.find("[name^=item_name]").val();
//       item.stockNumber = $item.find("[name^=item_stock_number]").val();
//       item.quantity = $item.find("[name^=item_quantity]").val();
//     },
//     newItem: function(e) {
//       e.preventDefault();
//       var item = this.add();
//       var $item = $(this.template.replace(/ID/g, item.id));
//
//       $("#inventory").append($item);
//     },
//     findParent: function(e) {
//       return $(e.target).closest("tr");
//     },
//     findID: function($item) {
//       return +$item.find("input[type=hidden]").val();
//     },
//     deleteItem: function(e) {
//       e.preventDefault();
//       var $item = this.findParent(e).remove();
//
//       this.remove(this.findID($item));
//     },
//     updateItem: function(e) {
//       var $item = this.findParent(e);
//
//       this.update($item);
//     },
//     bindEvents: function() {
//       $("#add_item").on("click", this.newItem.bind(this));
//       $("#inventory").on("click", 'a.delete', this.deleteItem.bind(this));
//       $("#inventory").on("blur", ':input', this.updateItem.bind(this));
//     },
//     init: function() {
//       this.setDate();
//       this.cacheTemplate();
//       this.bindEvents();
//     }
//   };
// })();
//
// $(inventory.init.bind(inventory));




// MY SOLUTION
// var inventory;
//
// (function() {
//   inventory = {
//     collection: [],
//     lastId: 0,
//     find: function(id) {
//       return this.collection.find(function(collItem) {
//         return collItem.id === id;
//       });
//     },
//     addItem: function(item) {
//       if (item) {
//         var collectionItem = this.find(parseInt(item.id, 10));
//         collectionItem.name = item.name || "";
//         collectionItem.stockNumber = item.stockNumber || "";
//         collectionItem.quantity = item.quantity || 1;
//       } else {
//         this.lastId++;
//         this.collection.push({
//           id: this.lastId,
//           name: "",
//           stockNumber: "",
//           quantity: '1',
//         });
//       }
//     },
//     removeItemFromCollection: function(id) {
//       console.log(id);
//       var itemIndex = this.collection.findIndex(function(item) {
//         return item.id.toString() === id;
//       });
//       console.log(itemIndex);
//       this.collection.splice(itemIndex, 1);
//     },
//     setDate: function() {
//       var date = new Date();
//       $('#order_date').text(date.toUTCString());
//     },
//     cacheTemplate: function() {
//       var $i_tmpl = $("#inventory_item").remove();
//       this.template = $i_tmpl.html();
//     },
//     makeAddItemHandler: function() {
//       var self = this;
//       $('#add_item').on("click", function() {
//         self.addItem();
//         $("#inventory").append(self.template.replace(/ID/g, self.lastId.toString()));
//       });
//     },
//     makeUpdateInventoryOnBlur: function() {
//       var self = this;
//       $('#inventory').on("blur", 'input', function() {
//         var $target = $(this);
//         var $tr = $target.closest('tr');
//         var id = $tr.find('[name^="item_id"]').val();
//         var name = $tr.find('[name^="item_name"]').val();
//         var stockNumber = $tr.find('[name^="item_stock_number"]').val();
//         var quantity = $tr.find('[name^="item_quantity"]').val();
//         // console.log("id: %s, name: %s, stockNumber: %s, quantity: %s", id, name, stockNumber, quantity);
//         self.addItem({
//           id: id,
//           name: name,
//           stockNumber: stockNumber,
//           quantity: quantity,
//         });
//       });
//     },
//     makeDeleteItem: function() {
//       var self = this;
//       $('#inventory').on("click", 'a', function(e) {
//         e.preventDefault();
//         var $target = $(this);
//         var $tr = $target.closest('tr');
//         var id = $tr.find("[name^='item_id']").val();
//         self.removeItemFromCollection(id);
//         $tr.remove();
//       });
//     },
//     init: function() {
//       this.setDate();
//       this.cacheTemplate();
//       this.makeAddItemHandler();
//       this.makeUpdateInventoryOnBlur();
//       this.makeDeleteItem();
//     }
//   };
// })();
//
// $(inventory.init.bind(inventory));
