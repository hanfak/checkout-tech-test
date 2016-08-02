describe Checkout do
  subject(:checkout_no_discount) { described_class.new(promotion_rules) }
  let(:promotion_rules) { double(:PromotionRules, total_discount: 0, total_discount_limit: 0, multibuy_amount: 2) }

  let(:item001) {double(:item, product_code: '001', name: 'Lavender heart', price: 9.25)}
  let(:item002) {double(:item, product_code: '002', name: 'Kids T-shirt', price: 19.95)}
    let(:item003) { Item.new( {product_code: '002', name: 'Personalised cufflinks', price: 45.0} ) }

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
    let(:promotion_rules) { double(:PromotionRules, total_discount: 0.1, total_discount_limit: 60.0,
    multibuy_item: item001,
    multibuy_price: 8.5, multibuy_amount: 2 ) }

    it 'discounts when above specific total' do
      4.times {checkout.scan(item002)}

      expect(checkout.total).to eq 71.82
    end

    it 'no discounts when multiple scans less than discount amount' do
      2.times {checkout.scan(item002)}

      expect(checkout.total).to eq 39.9
    end

    it 'multi buy discounts when 2 scans less than discount amount' do
      2.times {checkout.scan(item001)}

      expect(checkout.total).to eq 17.0
    end

    it 'multi buy discounts when multiple scans less than discount amount' do
      5.times {checkout.scan(item001)}

      expect(checkout.total).to eq 42.5
    end

    it 'handles totals involving floating point errors' do
      checkout.scan(item001)
      p checkout.total
      checkout.scan(item003)
      p checkout.total
      checkout.scan(item001)

      expect(checkout.total).to eq 55.8
    end
  end
end
