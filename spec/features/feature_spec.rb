feature 'User story 1' do
  let(:checkout) {Checkout.new}
  let(:item1) {Item.new(1, 'Lavender heart', 9.25 )}
  let(:item2) {Item.new(2, 'Personalised cufflinks', 45.0)}
  let(:item3) {Item.new(3, 'Kids T-shirt', 19.95 )}
  scenario 'find total of basket' do

    checkout.scan(item1)
    checkout.scan(item2)
    checkout.scan(item3)

    actual_price = checkout.total

    expect(actual_price).to eq 74.2
  end
end
