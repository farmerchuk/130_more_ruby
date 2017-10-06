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

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def each
    counter = 0

    while counter < todos.size
      todo = todos[counter]
      yield(todo)
      counter += 1
    end

    self
  end

  def select
    new_todo_list = TodoList.new(title)
    todos.each_with_object(new_todo_list) do |todo, results|
      results << todo if yield todo
    end
  end

  def add(todo)
    if todo.class == Todo
      todos << todo
    else
      raise TypeError, 'Can only add Todo objects'
    end
  end

  alias_method :<<, :add

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def item_at(index)
    if index >= todos.size || index < 0
      raise IndexError
    else
      todos[index]
    end
  end

  def mark_done_at(index)
    if index >= todos.size || index < 0
      raise IndexError
    else
      todos[index].done!
    end
  end

  def mark_undone_at(index)
    if index >= todos.size || index < 0
      raise IndexError
    else
      todos[index].undone!
    end
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    if index >= todos.size || index < 0
      raise IndexError
    else
      todos.remove_at(index)
    end
  end

  def to_s
    text = "--- #{title} ---\n"
    text << todos.map(&:to_s).join("\n")
    text
  end

  private

  attr_accessor :todos

end
