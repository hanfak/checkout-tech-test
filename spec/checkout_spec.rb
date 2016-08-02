describe Checkout do
  subject(:checkout) {described_class.new}
  let(:item1) {double(:item, product_code: 1, name: 'Lavender heart', price: 9.25)}

  describe 'defaults' do
    it 'has 0 balance' do
      expect(checkout.total).to eq 0.0
    end
  end

  describe '#scan' do
    it 'updates the balance of 1 item' do
      checkout.scan(item1)
      expect(checkout.total).to eq 9.25
    end
  end
end
