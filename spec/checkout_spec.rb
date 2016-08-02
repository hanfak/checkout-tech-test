describe Checkout do
  subject(:checkout) {described_class.new}

  describe 'defaults' do
    it 'has 0 balance' do
      expect(checkout.total).to eq 0.0
    end
  end

end
