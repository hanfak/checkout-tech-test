describe PromotionRules do
  subject(:promotion_rules) {described_class.new}
  subject(:promotion_rules_discount) {described_class.new(60.0, 0.1)}

  describe 'defaults' do
    it 'has no discount' do
      expect(promotion_rules.total_discount).to eq 0.0
    end

    it 'has 0 total discount limit' do
      expect(promotion_rules.total_discount_limit).to eq 0.0
    end
  end

  describe '#total_discount' do
    it 'instantiated with discount amount' do
      expect(promotion_rules_discount.total_discount).to eq 0.1
    end
  end

  describe '#total_discount_limit' do
    it 'instantiated with limit for discount amount' do
      expect(promotion_rules_discount.total_discount_limit).to eq 60.0
    end
  end
end
