describe Basket do
  let(:promo_rules_default) { double(:PromotionRules, total_discount: 0.0,
                          total_discount_limit: 0.0,  multibuy_item: nil,
                          multibuy_price: 0.0, multibuy_amount: 2 ) }
  subject(:basket) { described_class.new(promo_rules_default) }

  let(:item001) {double(:item, product_code: '001', name: 'Lavender heart', price: 9.25)}
  let(:item002) {double(:item, product_code: '002', name: 'Kids T-shirt', price: 19.95)}
  let(:item003) { double(:item, product_code: '003', name: 'Personalised cufflinks', price: 45.0) }

  it 'starts with no items' do
    expect(basket.scanned_items.size).to eq 0
  end

  describe '#add' do
    it 'adds an item to scanned items' do
      basket.add(item001)

      expect(basket.scanned_items.size).not_to eq 0
      expect(basket.scanned_items[0]).to eq item001
    end

    it 'adds several items to scanned items' do
      basket.add(item001)
      basket.add(item002)
      basket.add(item003)

      expect(basket.scanned_items.size).to eq 3
      expect(basket.scanned_items).to eq [item001, item002, item003]
    end
  end

  describe '#apply_multibuy' do
    subject(:basket) { described_class.new(promotion_rules) }
    let(:promotion_rules) { double(:PromotionRules, total_discount: 0.1,
                                total_discount_limit: 60.0,
                                multibuy_item: item001,
                                multibuy_price: 8.5, multibuy_amount: 2 ) }
    context 'success' do
      it 'changes price of item, matches minimum number of required items' do
        basket.add(item001)
        basket.add(item001)

        basket.apply_multibuy

        expect(basket.scanned_items[0].price).to eq 8.5
        expect(basket.scanned_items[1].price).to eq 8.5
      end

      it 'changes price of item, more than minimum number of required items' do
        basket.add(item001)
        basket.add(item001)
        basket.add(item001)

        basket.apply_multibuy

        expect(basket.scanned_items[0].price).to eq 8.5
        expect(basket.scanned_items[1].price).to eq 8.5
        expect(basket.scanned_items[2].price).to eq 8.5
      end
    end

    context 'failure' do
      it 'not change price of item , if not in list and more than the required items in list' do
        basket.add(item002)
        basket.add(item002)
        basket.add(item002)

        basket.apply_multibuy

        expect(basket.scanned_items[0].price).not_to eq 8.5
        expect(basket.scanned_items[1].price).not_to eq 8.5
        expect(basket.scanned_items[2].price).not_to eq 8.5
      end

      it 'not change price of item , if in list and not more than the required items in list' do
        basket.add(item001)

        basket.apply_multibuy

        expect(basket.scanned_items[0].price).not_to eq 8.5
      end

      it 'not change price of item , if not in list and not more than the required items in list' do
        basket.add(item002)

        basket.apply_multibuy

        expect(basket.scanned_items[0].price).not_to eq 8.5
      end
    end
  end

end
