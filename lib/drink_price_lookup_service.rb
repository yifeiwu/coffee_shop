# frozen_string_literal: true

require 'JSON'

# Return the price of a particular drink
class DrinkPriceLookupService
  def initialize(source:)
    @prices = JSON.load_file(source)
  rescue StandardError => e
    raise "Prices failed to load. #{e.inspect}"
  end

  def lookup_price(drink:, size:)
    drink_item = @prices.find { |item| item['drink_name'] == drink }
    price = drink_item.dig('prices', size)

    raise "Price not found for drink_name:#{drink}, size:#{size}" unless price

    price
  end
end
