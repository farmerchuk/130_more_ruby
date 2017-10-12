# cash_register_tests.rb

require 'minitest/autorun'

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTests < Minitest::Test

  # CashRegister tests

  def silence
    capture_io do
      yield
    end
  end

  def test_accept_money
    @register = CashRegister.new(0)
    @transaction = Transaction.new(10)
    @transaction.amount_paid = 20

    before_register_value = @register.total_money
    @register.accept_money(@transaction)
    after_register_value = @register.total_money
    assert_equal(before_register_value + 20, after_register_value)
  end

  def test_change
    @register = CashRegister.new(0)
    @transaction = Transaction.new(10)
    @transaction.amount_paid = 20

    change_value = @register.change(@transaction)
    assert_equal(10, change_value)
  end

  def test_give_receipt
    @register = CashRegister.new(0)
    @transaction = Transaction.new(10)

    results = silence { @register.give_receipt(@transaction) }
    assert_equal("You've paid $10.\n", results[0])
    silence { assert_nil(@register.give_receipt(@transaction)) }
  end

  # Transaction tests

  def test_prompt_for_payment
    @transaction = Transaction.new(10)
    @transaction.amount_paid = 10

    silence { @transaction.prompt_for_payment(input: StringIO.new('10\n')) }
    assert_equal(10, @transaction.amount_paid)
  end
end
