require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'scrap'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
    assert_equal(3, car.wheels)
  end
end
