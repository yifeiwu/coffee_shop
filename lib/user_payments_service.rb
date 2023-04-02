# frozen_string_literal: true

# Calculate previous and outstanding payments based on order balance
class UserPaymentsService
  def initialize(payments:, order_totals:)
    @payments_json = payments
    @order_totals = order_totals
  end

  def create_invoice
    total_payments = total_payments(payments_json: @payments_json)

    generate_results(total_payments: total_payments, order_totals: @order_totals)
  end

  private

  def total_payments(payments_json:)
    user_payments = Hash.new { 0 }
    payments_json.each do |payment|
      user_payments[(payment['user']).to_s] += payment['amount']
    end
    user_payments
  end

  def generate_results(total_payments:, order_totals:)
    results = []
    order_totals.each do |user, order_total|
      results << Hash[
        'user', user,
        'order_total', format_price(order_total),
        'payment_total', format_price(total_payments[user]),
        'balance', (format_price(order_total) - format_price(total_payments[user]))
        ]
    end
    results
  end

  def format_price(price)
    price ? price.to_f.round(2) : 0
  end
end
