var todoItems = [{id: 1, title: 'Homework'},
              {id: 2, title: 'Shopping'},
              {id: 3, title: 'Calling Mom'},
              {id: 4, title: 'Coffee with John'}];

var App = {
  todos: todoItems,
  todosTemplate: Handlebars.compile($('#todos_template').html()),
  confirmTemplate: Handlebars.compile($('#confirm_template').html()),
  $todos: $('#todos'),
  $confirmModal: $('.confirm_modal'),

  renderTodos: function() {
    this.$todos.html(this.todosTemplate({ todos: this.todos }));
  },

  remove: function(id) {
    var index = this.todos.findIndex(function(todo) {
      return todo.id === id;
    });

    this.todos.splice(index, 1);
  },

  showModal: function(e) {
    e.preventDefault();
    console.log(e.target);
    var id = Number($(e.target).closest('li').attr('data-id'));
    var todo = this.todos.find(function(todo) {
      return todo.id === id;
    });

    this.$confirmModal.html(this.confirmTemplate(todo));
    $('.confirm_modal, .overlay').show();
  },

  hideModal: function() {
    $('.confirm_modal, .overlay').hide();
    this.$confirmModal.html('');
  },

  handleConfirm: function(e) {
    e.preventDefault();
    var $a = $(e.target);
    if ($a.hasClass('confirm_yes')) {
      var id = Number($a.closest('.confirm_wrapper').attr('data-id'));
      this.remove(id);
      this.renderTodos();
    }
    this.hideModal();
  },

  init: function() {
    this.renderTodos();
    this.$todos.on('click', 'li .remove', this.showModal.bind(this));
    this.$confirmModal.on('click', 'a', this.handleConfirm.bind(this));
  },
};

App.init();
