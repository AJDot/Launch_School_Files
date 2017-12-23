var todoItems = [{id: 1, title: 'Homework'},
              {id: 2, title: 'Shopping'},
              {id: 3, title: 'Calling Mom'},
              {id: 4, title: 'Coffee with John'}];

var App = {
  todos: todoItems,
  todosTemplate: Handlebars.compile($('#todos_template').html()),
  confirmTemplate: Handlebars.compile($('#confirm_template').html()),
  contextMenuTemplate: Handlebars.compile($('#context_menu_template').html()),
  $todos: $('#todos'),
  $confirmModal: $('.confirm_modal'),
  $contextMenu: $('.context_menu'),

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
    var id = Number($(e.target).closest('ul').attr('data-id'));
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

  showContextMenu: function(e) {
    e.preventDefault();
    var coords = {
      top: e.clientY,
      left: e.clientX,
    }

    var id = Number($(e.target).attr('data-id'));
    this.$contextMenu.html(this.contextMenuTemplate({ id: id }));
    this.$contextMenu.show().offset(coords);
  },

  hideContextMenu: function() {
    this.$contextMenu.hide();
  },

  handleDeleteMenuClick: function(e) {
    e.preventDefault();
    this.showModal(e);
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
    this.$todos.on('contextmenu', 'li', this.showContextMenu.bind(this));
    this.$contextMenu.on('click', 'li.remove', this.handleDeleteMenuClick.bind(this));
    this.$confirmModal.on('click', 'a', this.handleConfirm.bind(this));
    $(document.body).on('click', this.hideContextMenu.bind(this));
  },
};

App.init();
