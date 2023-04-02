# frozen_string_literal: true

require 'user_payments_service'

describe 'user_payments_service' do
  let(:payments) { JSON.load_file('./spec/fixtures/payments.json') }
  describe '#initialize' do
    it 'raises if no payment are supplied' do
      expect { UserPaymentsService.new }.to raise_error(ArgumentError)
    end

    it 'reads in payments and order totals per user' do
      expect { UserPaymentsService.new(payments: payments, order_totals: {}) }
    end
  end

  describe '#calculate_balance' do
    describe 'there are no orders' do
      let(:order_totals) do
        {}
      end
      let(:subject) { UserPaymentsService.new(payments: payments, order_totals: order_totals) }

      it 'returns a blank array' do
        expected_result = subject.create_invoice
        expect(expected_result).to eq([])
      end
    end

    describe 'there are orders' do
      let(:order_totals) do
        { 'coach' => 80, 'ellis' => 5 }
      end
      let(:subject) { UserPaymentsService.new(payments: payments, order_totals: order_totals) }

      it 'returns results for people with orders: what each person paid and the remaining balance' do
        expected_result = subject.create_invoice
        expect(expected_result).to eq([{ 'user' => 'coach', 'order_total' => 80.0, 'payment_total' => 69.0, 'balance' => 11.0 },
                                       { 'user' => 'ellis', 'order_total' => 5.0, 'payment_total' => 24.0,
                                         'balance' => -19.0 }])
      end
    end
  end
end
