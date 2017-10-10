require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todo'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal([], @list.all_done)
  end

  def test_type_error
    assert_raises(TypeError) { @list << String.new }
    assert_raises(TypeError) { @list << Array.new }
  end

  def test_add
    @new_todo = Todo.new("Study for test")
    @list.add(@new_todo)
    @todos << @new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_add_alias
    @new_todo = Todo.new("Study for test")
    @list << @new_todo
    @todos << @new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(-1) }
    assert_equal(@todo1, @list.item_at(0))
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert_raises(IndexError) { @list.mark_done_at(-1) }
    assert_equal(true, @list.item_at(0).done?)
    assert_equal(false, @list.item_at(1).done?)
  end

  def test_mark_undone_at
    @list.mark_done_at(0)
    @list.mark_undone_at(0)
    assert_raises(IndexError) { @list.mark_undone_at(-1) }
    assert_equal(false, @list.item_at(0).done?)
    assert_equal(false, @list.item_at(1).done?)
  end

  def test_mark_all_done
    @list.mark_all_done
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(-1) }
    assert_equal(@todo1, @list.remove_at(0))
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    --- Today's Todos ---
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    @list.mark_all_done
    output = <<~OUTPUT.chomp
    --- Today's Todos ---
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_each
    @list.each { |todo| assert(todo) }
  end

  def test_each_return_value
    assert_same(@list, @list.each)
  end

  def test_select
    result = @list.select { |todo| todo.done? }
    assert_equal([], result.to_a)
  end
end
