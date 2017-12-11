var todoItems = [{id: 1, title: 'Homework'},
                {id: 2, title: 'Shopping'},
                {id: 3, title: 'Calling Mom'},
                {id: 4, title: 'Coffee with John'}];

var App = {
  todos: todoItems,
  todosTemplate: Handlebars.compile($('#todos_template').html()),
  confirmTemplate: Handlebars.compile($('#confirm_template').html()),
  $todos: $('#todos'),
  $confirm: $('.confirm_prompt'),

  renderTodos: function() {
    this.$todos.append(this.todosTemplate({ todos: this.todos }));
  },

  removeTodo: function(e) {

  }

  init: function() {
    this.renderTodos();
  },

}

App.init();
