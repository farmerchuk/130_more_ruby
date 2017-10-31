require 'minitest/autorun'
require 'pry'

class Palindromes
  attr_accessor :max, :min, :range, :pals,
                :largest_pal_value, :smallest_pal_value

  Palindrome = Struct.new(:factors, :value)

  def initialize(factors)
    @max = factors[:max_factor]
    @min = factors[:min_factor] || 1
    @range = min.upto(max).to_a
    @pals = []
    @largest_pal_value = 0
    @smallest_pal_value = 0
  end

  def generate
    combos = range.product(range)

    combos.each do |combo|
      product = combo.reduce(&:*)
      pals << combo if palindrome?(product)
    end
  end

  def largest
    find_largest_palindrome_product

    largest_pals = pals.each_with_object([]) do |combo, ary|
      prod = combo.reduce(&:*)
      ary << combo.sort if prod == largest_pal_value
    end.uniq

    Palindrome.new(largest_pals, largest_pal_value)
  end

  def smallest
    find_smallest_palindrome_product

    smallest_pals = pals.each_with_object([]) do |combo, ary|
      prod = combo.reduce(&:*)
      ary << combo.sort if prod == smallest_pal_value
    end.uniq

    Palindrome.new(smallest_pals, smallest_pal_value)
  end

  private

  def palindrome?(int)
    int.to_s.reverse == int.to_s
  end

  def find_largest_palindrome_product
    pals.each do |combo|
      prod = combo.reduce(&:*)
      self.largest_pal_value = prod if prod >= largest_pal_value
    end
  end

  def find_smallest_palindrome_product
    self.smallest_pal_value = pals[0].reduce(&:*)

    pals.each do |combo|
      prod = combo.reduce(&:*)
      self.smallest_pal_value = prod if prod < smallest_pal_value
    end
  end
end

class PalindromesTest < Minitest::Test
  def test_largest_palindrome_from_single_digit_factors
    palindromes = Palindromes.new(max_factor: 9)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 9, largest.value
    assert_includes [[[3, 3], [1, 9]], [[1, 9], [3, 3]]], largest.factors
  end

  def test_largest_palindrome_from_double_digit_factors
    palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 9009, largest.value
    assert_equal [[91, 99]], largest.factors
  end

  def test_smallest_palindrome_from_double_digit_factors
    palindromes = Palindromes.new(max_factor: 99, min_factor: 10)
    palindromes.generate
    smallest = palindromes.smallest
    assert_equal 121, smallest.value
    assert_equal [[11, 11]], smallest.factors
  end

  def test_largest_palindrome_from_triple_digit_factors
    palindromes = Palindromes.new(max_factor: 999, min_factor: 100)
    palindromes.generate
    largest = palindromes.largest
    assert_equal 906_609, largest.value
    assert_equal [[913, 993]], largest.factors
  end

  def test_smallest_palindrome_from_triple_digit_factors
    palindromes = Palindromes.new(max_factor: 999, min_factor: 100)
    palindromes.generate
    smallest = palindromes.smallest
    assert_equal 10_201, smallest.value
    assert_equal [[101, 101]], smallest.factors
  end
end
