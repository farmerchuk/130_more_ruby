require 'minitest/autorun'
require 'pry'

class Integer
  KEY = { 1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV', 5 => 'V',
          6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX' }

  def to_roman
    n = self
    result = ''

    thousands = n / 1000
    hundreds = n % 1000 / 100
    tens = n % 100 / 10
    ones = n % 10

    result << ('M' * thousands) unless thousands.zero?
    result << 'CM' if hundreds == 9
    result << 'D' if (5...9).include?(hundreds)
    result << 'CD' if hundreds == 4
    result << 'C' * hundreds if [1, 2, 3].include?(hundreds)
    result << 'C' * (hundreds - 5) if [6, 7, 8].include?(hundreds)
    result << 'L' if (5...9).include?(tens)
    result << 'XC' if tens == 9
    result << 'XL' if tens == 4
    result << 'X' * tens if [1, 2, 3].include?(tens)
    result << 'X' * (tens - 5) if [6, 7, 8].include?(tens)
    result << KEY[ones] if ones > 0

    result
  end
end

class RomanNumeralsTest < Minitest::Test
  def test_1
    assert_equal 'I', 1.to_roman
  end

  def test_2
    assert_equal 'II', 2.to_roman
  end

  def test_3
    assert_equal 'III', 3.to_roman
  end

  def test_4
    assert_equal 'IV', 4.to_roman
  end

  def test_5
    assert_equal 'V', 5.to_roman
  end

  def test_6
    assert_equal 'VI', 6.to_roman
  end

  def test_9
    assert_equal 'IX', 9.to_roman
  end

  def test_27
    assert_equal 'XXVII', 27.to_roman
  end

  def test_48
    assert_equal 'XLVIII', 48.to_roman
  end

  def test_59
    assert_equal 'LIX', 59.to_roman
  end

  def test_93
    assert_equal 'XCIII', 93.to_roman
  end

  def test_141
    assert_equal 'CXLI', 141.to_roman
  end

  def test_163
    assert_equal 'CLXIII', 163.to_roman
  end

  def test_402
    assert_equal 'CDII', 402.to_roman
  end

  def test_575
    assert_equal 'DLXXV', 575.to_roman
  end

  def test_911
    assert_equal 'CMXI', 911.to_roman
  end

  def test_1024
    assert_equal 'MXXIV', 1024.to_roman
  end

  def test_3000
    assert_equal 'MMM', 3000.to_roman
  end
end
