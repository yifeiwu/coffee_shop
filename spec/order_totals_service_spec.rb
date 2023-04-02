# frozen_string_literal: true

require 'order_totals_service'

describe 'order_totals_service' do
  let(:orders) { JSON.load_file('./spec/fixtures/orders.json') }
  describe '#initialize' do
    it 'raises if no source is supplied' do
      expect { OrderTotalsService.new }.to raise_error(ArgumentError)
    end

    it 'reads in a source and price service' do
      expect { OrderTotalsService.new(orders: orders, price_service: double) }
    end
  end

  describe '#calculate_user_totals' do
    let(:price_service) do
      double('dollar_store_prices', lookup_price: 1) # everything costs $1
    end

    let(:subject) { OrderTotalsService.new(orders: orders, price_service: price_service) }

    it 'returns the total of all the drinks each person ordered' do
      expected_result = subject.calculate_user_totals
      expect(expected_result).to eq({ 'coach' => 2, 'ellis' => 1, 'rochelle' => 1 })
    end
  end
end
