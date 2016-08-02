feature 'User story 1' do
  let(:checkout) {Checkout.new}
  let(:item001) { Item.new( {product_code: '001', name: 'Lavender heart', price: 9.25} ) }
  let(:item002) { Item.new( {product_code: '002', name: 'Personalised cufflinks', price: 45.0} ) }
  let(:item003) { Item.new( {product_code: '003', name: 'Kids T-shirt', price: 19.95 } ) }

  scenario 'find total of basket' do

    checkout.scan(item001)
    checkout.scan(item002)
    checkout.scan(item003)

    actual_price = checkout.total

    expect(actual_price).to eq 74.2
  end
end
