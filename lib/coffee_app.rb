# frozen_string_literal: true

require 'drink_price_lookup_service'
require 'order_totals_service'
require 'user_payments_service'
require 'JSON'

# Gathers order from users and calculates the balance to be paid
module CoffeeApp
  def self.call(prices, orders, payments)
    prices = JSON.parse(prices)
    orders = JSON.parse(orders)
    payments = JSON.parse(payments)

    price_service = DrinkPriceLookupService.new(source: prices)
    order_totals_service = OrderTotalsService.new(orders: orders, price_service: price_service)
    order_totals = order_totals_service.calculate_user_totals

    user_payments_service = UserPaymentsService.new(payments: payments, order_totals: order_totals)

    results = user_payments_service.create_invoice
    JSON.dump(results)
  end
end
