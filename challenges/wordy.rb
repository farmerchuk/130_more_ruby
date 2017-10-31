require 'minitest/autorun'

class WordProblem
  OPERATORS = "plus|minus|multiplied by|divided by"

  def initialize(string)
    @equation = format_string_to_array(string)

    raise ArgumentError if @equation.any? { |e| e.match(/[^+-\/*\s\d]/)}
  end

  def answer
    first_result = eval @equation.slice!(0, 3).join(' ')
    @equation.insert(0, first_result)
    eval @equation.join(' ')
  end

  private

  def format_string_to_array(string)
    new_string = string.gsub(/What is +|[?]/, '')

    new_string.gsub(/#{OPERATORS}/) do |match|
      case match
      when 'plus' then '+'
      when 'minus' then '-'
      when 'multiplied by' then '*'
      when 'divided by' then '/'
      end
    end.split
  end
end

class WordProblemTest < Minitest::Test
  def test_add_1
    assert_equal 2, WordProblem.new('What is 1 plus 1?').answer
  end

  def test_add_2
    assert_equal 55, WordProblem.new('What is 53 plus 2?').answer
  end

  def test_add_negative_numbers
    assert_equal(-11, WordProblem.new('What is -1 plus -10?').answer)
  end

  def test_add_more_digits
    assert_equal 45_801, WordProblem.new('What is 123 plus 45678?').answer
  end

  def test_subtract
    assert_equal 16, WordProblem.new('What is 4 minus -12?').answer
  end

  def test_multiply
    assert_equal(-75, WordProblem.new('What is -3 multiplied by 25?').answer)
  end

  def test_divide
    assert_equal(-11, WordProblem.new('What is 33 divided by -3?').answer)
  end

  def test_add_twice
    question = 'What is 1 plus 1 plus 1?'
    assert_equal 3, WordProblem.new(question).answer
  end

  def test_add_then_subtract
    question = 'What is 1 plus 5 minus -2?'
    assert_equal 8, WordProblem.new(question).answer
  end

  def test_subtract_twice
    question = 'What is 20 minus 4 minus 13?'
    assert_equal 3, WordProblem.new(question).answer
  end

  def test_subtract_then_add
    question = 'What is 17 minus 6 plus 3?'
    assert_equal 14, WordProblem.new(question).answer
  end

  def test_multiply_twice
    question = 'What is 2 multiplied by -2 multiplied by 3?'
    assert_equal(-12, WordProblem.new(question).answer)
  end

  def test_add_then_multiply
    question = 'What is -3 plus 7 multiplied by -2?'
    assert_equal(-8, WordProblem.new(question).answer)
  end

  def test_divide_twice
    question = 'What is -12 divided by 2 divided by -3?'
    assert_equal 2, WordProblem.new(question).answer
  end

  def test_too_advanced
    assert_raises ArgumentError do
      WordProblem.new('What is 53 cubed?').answer
    end
  end

  def test_irrelevant
    assert_raises ArgumentError do
      WordProblem.new('Who is the president of the United States?').answer
    end
  end
end
