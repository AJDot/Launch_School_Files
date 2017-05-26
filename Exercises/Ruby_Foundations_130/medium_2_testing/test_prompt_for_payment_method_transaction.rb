require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    amount = StringIO.new("10\n")

    transaction = Transaction.new(10)
    transaction.prompt_for_payment(input: amount)
    assert_equal 10, transaction.amount_paid
  end
end