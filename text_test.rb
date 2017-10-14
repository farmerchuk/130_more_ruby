require 'minitest/autorun'
require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @text = Text.new(File.read('./text.txt'))
  end

  def test_swap
    swapped_once = @text.swap('a', 'e')
    swapped_twice = @text.swap('e', 'a')
    swapped_thrice = @text.swap('a', 'e')

    assert_equal(swapped_once, swapped_thrice)
  end

  def teardown
    setup
  end
end
