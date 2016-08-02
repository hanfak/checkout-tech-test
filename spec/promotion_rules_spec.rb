describe PromotionRules do
  subject(:promotion_rules) {described_class.new}
  subject(:promotion_rules_discount) {described_class.new( {total_discount_limit: 60.0, total_discount: 0.1} )}
  subject(:promotion_rules_no_limit) {described_class.new( {total_discount: 0.1} )}

  describe 'defaults' do
    it 'has no discount' do
      expect(promotion_rules.total_discount).to eq 0.0
    end

    it 'has 0 total discount limit' do
      expect(promotion_rules.total_discount_limit).to eq 0.0
    end
  end

  describe '#total_discount' do
    subject(:promotion_rules_negative_limit) {described_class.new( {total_discount: 0.1, total_discount_limit: - 60.0 } )}

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
end
