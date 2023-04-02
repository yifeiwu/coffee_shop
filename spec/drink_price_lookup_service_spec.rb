# frozen_string_literal: true

require 'drink_price_lookup_service'

describe 'drink_price_lookup_service' do
  let(:source) { JSON.load_file('./spec/fixtures/prices.json') }
  describe '#initialize' do
    it 'raises if no source is supplied' do
      expect { DrinkPriceLookupService.new }.to raise_error(ArgumentError)
    end

    it 'reads in a pricing source' do
      expect { DrinkPriceLookupService.new(source: source) }
    end
  end

  describe '#drink_price' do
    let(:subject) { DrinkPriceLookupService.new(source: source) }

    it 'returns the price of a drink given the name and size' do
      expected_price = subject.lookup_price(drink: 'short espresso', size: 'small')
      expect(expected_price).to eq 3.0
    end

    it 'raises an error if drink size is not found' do
      expect { subject.lookup_price(drink: 'short espresso', size: 'venti!') }.to raise_error(/Price not found/)
    end

    it 'raises an error if drink name is not found' do
      expect { subject.lookup_price(drink: 'magic potion', size: 'venti!') }.to raise_error(/Price not found/)
    end
  end
end
