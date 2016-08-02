describe Item do
  subject(:item) {described_class.new('001', 'Lavender heart', 9.25)}

  describe "#initialize" do
    it "is initialized with a product code" do
     expect(item.product_code).to eq('001')
    end

    it "is initialized with a name" do
     expect(item.name).to eq('Lavender heart')
    end

    it "is initialized with a price" do
     expect(item.price).to eq(9.25)
    end
  end
end
