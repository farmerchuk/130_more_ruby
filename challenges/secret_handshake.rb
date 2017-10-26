require 'minitest/autorun'
require 'pry'

class SecretHandshake
  def initialize(input)
    @input = input
    @binary_string = convert_to_binary
  end

  def commands
    result = []

    result << 'wink' if binary_string[-1] == '1'
    result << 'double blink' if binary_string[-2] == '1'
    result << 'close your eyes' if binary_string[-3] == '1'
    result << 'jump' if binary_string[-4] == '1'
    result.reverse! if binary_string[-5] == '1'

    result
  end

  private

  attr_reader :input, :binary_string

  def convert_to_binary
    return binary_from_int if input.instance_of?(Integer)
    return input if input.instance_of?(String) && is_binary?
    return '0'
  end

  def is_binary?
    input.each_char.all? { |char| char.match(/[O1]/) }
  end

  def binary_from_int
    binary = ''
    quotient = input

    until quotient == 0
      binary << (quotient % 2).to_s
      quotient = quotient / 2
    end

    binary.reverse
  end
end

class SecretHandshakeTest < Minitest::Test
  def test_handshake_1_to_wink
    handshake = SecretHandshake.new(1)
    assert_equal ['wink'], handshake.commands
  end

  def test_handshake_10_to_double_blink
    handshake = SecretHandshake.new(2)
    assert_equal ['double blink'], handshake.commands
  end

  def test_handshake_100_to_close_your_eyes
    handshake = SecretHandshake.new(4)
    assert_equal ['close your eyes'], handshake.commands
  end

  def test_handshake_1000_to_jump
    handshake = SecretHandshake.new(8)
    assert_equal ['jump'], handshake.commands
  end

  def test_handshake_11_to_wink_and_double_blink
    handshake = SecretHandshake.new(3)
    assert_equal ['wink', 'double blink'], handshake.commands
  end

  def test_handshake_10011_to_double_blink_and_wink
    handshake = SecretHandshake.new(19)
    assert_equal ['double blink', 'wink'], handshake.commands
  end

  def test_handshake_11111_to_double_blink_and_wink
    handshake = SecretHandshake.new(31)
    expected = ['jump', 'close your eyes', 'double blink', 'wink']
    assert_equal expected, handshake.commands
  end

  def test_valid_string_input
    handshake = SecretHandshake.new('1')
    assert_equal ['wink'], handshake.commands
  end

  def test_invalid_handshake
    handshake = SecretHandshake.new('piggies')
    assert_equal [], handshake.commands
  end
end
