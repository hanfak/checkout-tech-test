describe PromotionRules do
  subject(:promotion_rules) {described_class.new}

  describe 'defaults' do
    it 'has total discount' do
      expect(promotion_rules.total_discount).to eq 0
    end
  end
end
