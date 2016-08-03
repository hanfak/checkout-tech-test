feature 'User story 1' do
  let(:promo_rules) { PromotionRules.new }
  let(:checkout) {Checkout.new(promo_rules)}
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

feature 'User story 2' do
  let(:promo_rules) { PromotionRules.new({total_discount_limit: 60.0, total_discount: 0.1}) }
  let(:checkout) {Checkout.new(promo_rules)}
  let(:item001) { Item.new( {product_code: '001', name: 'Lavender heart', price: 9.25} ) }
  let(:item002) { Item.new( {product_code: '002', name: 'Personalised cufflinks', price: 45.0} ) }
  let(:item003) { Item.new( {product_code: '003', name: 'Kids T-shirt', price: 19.95 } ) }

  scenario 'give discount when total greater than 60' do
    checkout.scan(item001)
    checkout.scan(item002)
    checkout.scan(item003)

    actual_price = checkout.total

    expect(actual_price).to eq 66.78
  end

end

feature 'User story 3' do
  let(:promo_rules) { PromotionRules.new( {
                        total_discount_limit: 60.0,
                        total_discount: 0.1,
                        multibuy_item: item001,
                        multibuy_price: 8.5} ) }
  let(:checkout) {Checkout.new(promo_rules)}
  let(:item001) { Item.new( {product_code: '001',
                            name: 'Lavender heart',
                            price: 9.25} ) }
  let(:item002) { Item.new( {product_code: '002', name: 'Personalised cufflinks', price: 45.0} ) }
  let(:item003) { Item.new( {product_code: '003', name: 'Kids T-shirt', price: 19.95 } ) }

  scenario 'give discount when buying multiple discounted item' do
    2.times { checkout.scan(item001) }

    actual_price = checkout.total

    expect(actual_price).to eq 17.0
  end

  scenario 'discount and other scan, only one discount' do
    checkout.scan(item001)
    checkout.scan(item002)
    checkout.scan(item001)
    actual_price = checkout.total

    expect(actual_price).to eq 55.8
  end

  scenario 'Both discounts' do
    checkout.scan(item001)
    checkout.scan(item002)
    checkout.scan(item001)
    checkout.scan(item003)

    actual_price = checkout.total

    expect(actual_price).to eq 73.76
  end



end
