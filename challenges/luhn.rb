require 'minitest/autorun'
require 'pry'

class Luhn
  def initialize(int)
    @int = int
  end

  def addends
    digits = int.to_s.chars.reverse.map(&:to_i)

    digits.map!.with_index do |digit, idx|
      if idx % 2 != 0
        new_digit = digit * 2
        new_digit >= 10 ? new_digit -= 9 : new_digit
      else
        digit
      end
    end

    digits.reverse
  end

  def checksum
    addends.reduce(&:+)
  end

  def valid?
    checksum.to_s[-1] == '0'
  end

  def self.create(int)
    0.upto(9).each do |n|
      new_int = (int.to_s << n.to_s).to_i
      new_luhn = Luhn.new(new_int)
      return new_int if new_luhn.valid?
    end
  end

  private

  attr_reader :int
end

class LuhnTest < Minitest::Test
  def test_addends
    luhn = Luhn.new(12_121)
    assert_equal [1, 4, 1, 4, 1], luhn.addends
  end

  def test_too_large_addend
    luhn = Luhn.new(8631)
    assert_equal [7, 6, 6, 1], luhn.addends
  end

  def test_checksum
    luhn = Luhn.new(4913)
    assert_equal 22, luhn.checksum
  end

  def test_checksum_again
    luhn = Luhn.new(201_773)
    assert_equal 21, luhn.checksum
  end

  def test_invalid_number
    luhn = Luhn.new(738)
    refute luhn.valid?
  end

  def test_valid_number
    luhn = Luhn.new(8_739_567)
    assert luhn.valid?
  end

  def test_create_valid_number
    number = Luhn.create(123)
    assert_equal 1230, number
  end

  def test_create_other_valid_number
    number = Luhn.create(873_956)
    assert_equal 8_739_567, number
  end

  def test_create_yet_another_valid_number
    number = Luhn.create(837_263_756)
    assert_equal 8_372_637_564, number
  end
end
