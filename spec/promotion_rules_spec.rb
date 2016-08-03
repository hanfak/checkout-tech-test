describe PromotionRules do
  subject(:promotion_rules_discount) { described_class.new( { total_discount_limit: 60.0, total_discount: 0.1, multibuy_item: item001, multibuy_price: 8.5, multibuy_amount: 4 } )}

  let(:item001) {double(:item, product_code: '001', name:  'Lavender heart', price: 9.25)}

  describe 'defaults' do
    subject(:promotion_rules) { described_class.new }

    it 'has no discount' do
      expect(promotion_rules.total_discount).to eq 0.0
    end

    it 'has 0 total discount limit' do
      expect(promotion_rules.total_discount_limit).to eq 0.0
    end

    it 'has no multibuy item' do
      expect(promotion_rules.multibuy_item).to eq nil
    end

    it 'has multibuy price of 0' do
      expect(promotion_rules.multibuy_price).to eq 0.0
    end

    it 'has multibuy amount of 2' do
      expect(promotion_rules.multibuy_amount).to eq 2
    end
  end

  describe '#total_discount' do
    subject(:promotion_rules_no_limit) { described_class.new( {total_discount: 0.1} )}
    subject(:promotion_rules_negative_limit) { described_class.new( {total_discount: 0.1, total_discount_limit: - 60.0 } )}

    it 'instantiated with discount amount' do
      expect(promotion_rules_discount.total_discount).to eq 0.1
    end

    it 'need discount limit to have discount' do
      expect(promotion_rules_no_limit.total_discount).to eq 0.0
    end

    it 'need positive discount limit to have discount' do
      expect(promotion_rules_negative_limit.total_discount).to eq 0.0
    end
  end

  describe '#total_discount_limit' do
    it 'instantiated with limit for discount amount' do
      expect(promotion_rules_discount.total_discount_limit).to eq 60.0
    end
  end

  describe '#multibuy_item' do
    it 'instantiated with multibuy_item' do
      expect(promotion_rules_discount.multibuy_item.name).to eq 'Lavender heart'
    end
  end

  describe '#multibuy_price' do
    it 'instantiated with multibuy_price' do
      expect(promotion_rules_discount.multibuy_price).to eq 8.5
    end
  end

  describe '#multibuy_amount' do
    it 'instantiated with multibuy_amount' do
      expect(promotion_rules_discount.multibuy_amount).to eq 4
    end
  end
end
