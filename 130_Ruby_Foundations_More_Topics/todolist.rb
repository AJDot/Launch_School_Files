class TodoListTypeError < TypeError; end

# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation
  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def add(obj)
    raise TypeError, "Can only add Todo objects" unless obj.instance_of? Todo
    @todos.push obj
  end

  alias_method :<<, :add

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    # @todos.select { |todo| yield(todo) }
    list = TodoList.new(title)
    each { |todo| list.add(todo) if yield(todo) }
    list
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

# given
todo1 = Todo.new("Buy milk 1")
todo2 = Todo.new("Clean room 2")
todo3 = Todo.new("Go to gym 3")
todo4 = Todo.new("Vacuum 4")
todo5 = Todo.new("Wash dishes 5")
todo6 = Todo.new("Run 6")
list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)
list.add(todo4)
list.add(todo5)
list.add(todo6)

puts '---#each---'
list.each { |todo| puts todo }

puts '---#select---'
list.mark_done_at(0)
results = list.select { |todo| todo.done? }

puts results.inspect

puts '---#find_by_title---'
puts list.find_by_title 'Buy milk 1'
puts list.find_by_title 'Eat chicken'

puts '---#all_done---'
puts list.all_done
list.mark_done_at(3)
puts list.all_done

puts '---#all_not_done---'
puts list.all_not_done
list.mark_done_at(1)
puts list.all_not_done

puts '---#mark_done---'
puts list
list.mark_done('Go to gym 3')
puts list

puts '---#mark_all_done---'
puts list
list.mark_all_done
puts list

puts '---#mark_all_undone---'
puts list
list.mark_all_undone
puts list
