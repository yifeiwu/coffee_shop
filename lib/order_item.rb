# frozen_string_literal: true

# line item on an order. usually a drink.
class OrderItem
  attr_accessor :name, :size

  def initialize(name:, size:)
    @name = name
    @size = size
  end
end
