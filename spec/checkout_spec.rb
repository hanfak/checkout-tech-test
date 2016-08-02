describe Checkout do
  subject(:checkout) {described_class.new}
  let(:item001) {double(:item, product_code: '001', name: 'Lavender heart', price: 9.25)}
  let(:item002) {double(:item, product_code: '002', name: 'Kids T-shirt', price: 19.95)}

  describe 'defaults' do
    it 'has 0 balance' do
      expect(checkout.total).to eq 0.0
    end
  end

  describe '#scan' do
    it 'updates the balance of 1 item' do
      checkout.scan(item001)
      expect(checkout.total).to eq 9.25
    end

    it 'updates the balance of items' do
      checkout.scan(item001)
      checkout.scan(item002)
      expect(checkout.total).to eq 29.2
    end
  end
end
