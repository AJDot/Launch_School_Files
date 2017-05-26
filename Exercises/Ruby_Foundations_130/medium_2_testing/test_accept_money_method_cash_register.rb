require 'minitest/autorun'

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    register = CashRegister.new(100)
    transaction = Transaction.new(10)
    transaction.amount_paid = 10

    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount= register.total_money

    assert_equal(previous_amount + 10, current_amount)
  end
end