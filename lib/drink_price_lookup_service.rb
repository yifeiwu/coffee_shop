# frozen_string_literal: true

# Return the price of a particular drink
class DrinkPriceLookupService
  def initialize(source:)
    @prices_json = source
  end

  def lookup_price(drink:, size:)
    drink_item = @prices_json.find { |item| item['drink_name'] == drink }
    price = drink_item&.dig('prices', size)

    raise "Price not found. Name:#{drink}, Size:#{size}" unless price

    price
  end
end
