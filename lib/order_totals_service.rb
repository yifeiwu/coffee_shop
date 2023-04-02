# frozen_string_literal: true

require 'order_item'

# Total order value per customer
class OrderTotalsService
  def initialize(orders:, price_service:)
    @orders_json = orders
    @price_service = price_service
  end

  def calculate_user_totals
    collated_orders = collate_orders(orders_json: @orders_json)

    calculate_user_order_totals(user_orders: collated_orders)
  end

  private

  def calculate_user_order_totals(user_orders:)
    user_order_totals = {}
    user_orders.each do |user, orders|
      user_order_totals[user.to_s] =
        orders.inject(0) { |total, item| total + @price_service.lookup_price(drink: item.name, size: item.size) }
    end
    user_order_totals
  end

  def collate_orders(orders_json:)
    # users start with an empty list of orders
    user_orders = Hash.new { |user_orders, user| user_orders[user] = [] }

    orders_json.each do |order|
      user_orders[order['user']] << OrderItem.new(name: order['drink'], size: order['size'])
    end
    user_orders
  end
end
