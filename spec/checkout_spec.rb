describe Checkout do
  subject(:checkout_no_discount) { described_class.new(promotion_rules) }
  let(:promotion_rules) { double(:PromotionRules, total_discount: 0, total_discount_limit: 0) }

  let(:item001) {double(:item, product_code: '001', name: 'Lavender heart', price: 9.25)}
  let(:item002) {double(:item, product_code: '002', name: 'Kids T-shirt', price: 19.95)}

  describe 'defaults' do
    it 'has 0 balance' do
      expect(checkout_no_discount.total).to eq 0.0
    end
  end

  describe '#scan' do
    it 'updates the balance of 1 item' do
      checkout_no_discount.scan(item001)

      expect(checkout_no_discount.total).to eq 9.25
    end

    it 'updates the balance of items' do
      checkout_no_discount.scan(item001)
      checkout_no_discount.scan(item002)

      expect(checkout_no_discount.total).to eq 29.2
    end
  end

  describe '#total' do
    subject(:checkout) { described_class.new(promotion_rules) }
    let(:promotion_rules) { double(:PromotionRules, total_discount: 0.1, total_discount_limit: 60.0) }

    it 'discounts when above specific total' do
      4.times {checkout.scan(item002)}

      expect(checkout.total).to eq 71.82
    end
  end
end
