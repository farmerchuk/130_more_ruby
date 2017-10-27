require 'minitest/autorun'

class PhoneNumber
  def initialize(string)
    @num = string
  end

  def number
    alphas = num.scan(/[a-zA-Z]/).count
    nums = num.scan(/[0-9]/).count

    return '0000000000' if nums < 10 ||
                           nums > 11 ||
                           nums == 11 && num[0] != '1' ||
                           alphas > 0

    num.gsub!(/[^0-9]/, '')

    num[0] == '1' && num.size == 11 ? num.slice(1..-1) : num
  end

  def area_code
    number[0, 3]
  end

  def to_s
    "(#{area_code}) #{number[3, 3]}-#{number[6, 4]}"
  end

  private

  attr_reader :num
end

class PhoneNumberTest < Minitest::Test
  def test_cleans_number
    number = PhoneNumber.new('(123) 456-7890').number
    assert_equal '1234567890', number
  end

  def test_cleans_a_different_number
    number = PhoneNumber.new('(987) 654-3210').number
    assert_equal '9876543210', number
  end

  def test_cleans_number_with_dots
    number = PhoneNumber.new('456.123.7890').number
    assert_equal '4561237890', number
  end

  def test_invalid_with_letters_in_place_of_numbers
    number = PhoneNumber.new('123-abc-1234').number
    assert_equal '0000000000', number
  end

  def test_invalid_when_9_digits
    number = PhoneNumber.new('123456789').number
    assert_equal '0000000000', number
  end

  def test_valid_when_11_digits_and_first_is_1
    number = PhoneNumber.new('19876543210').number
    assert_equal '9876543210', number
  end

  def test_valid_when_10_digits_and_area_code_starts_with_1
    number = PhoneNumber.new('1234567890').number
    assert_equal '1234567890', number
  end

  def test_invalid_when_11_digits
    number = PhoneNumber.new('21234567890').number
    assert_equal '0000000000', number
  end

  def test_invalid_when_12_digits_and_first_is_1
    number = PhoneNumber.new('112345678901').number
    assert_equal '0000000000', number
  end

  def test_invalid_when_10_digits_with_extra_letters
    number = PhoneNumber.new('1a2a3a4a5a6a7a8a9a0a').number
    assert_equal '0000000000', number
  end

  def test_area_code
    number = PhoneNumber.new('1234567890')
    assert_equal '123', number.area_code
  end

  def test_different_area_code
    number = PhoneNumber.new('9876543210')
    assert_equal '987', number.area_code
  end

  def test_pretty_print
    number = PhoneNumber.new('5551234567')
    assert_equal '(555) 123-4567', number.to_s
  end

  def test_pretty_print_with_full_us_phone_number
    number = PhoneNumber.new('11234567890')
    assert_equal '(123) 456-7890', number.to_s
  end
end
