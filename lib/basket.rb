class Basket
  attr_reader :scanned_items

  def initialize(promotion_rules)
    @scanned_items = []
    @promotion_rules = promotion_rules
  end

  def add(item)
    scanned_items << item
  end

  def apply_multibuy
    change_price_of_multibuy_items(promotion_rules.multibuy_item) if match_multibuy_criteria(promotion_rules.multibuy_item)
  end

  private
    attr_reader :promotion_rules

    def match_multibuy_criteria(item)
      scanned_items.include?(item) && scanned_items.count(item) >=  promotion_rules.multibuy_amount
    end

    def change_price_of_multibuy_items(item)
      @scanned_items.map! do |item_to_buy|
        if item_to_buy == item
          item_to_buy = Item.new({ product_code: item.product_code, name: item.name, price: promotion_rules.multibuy_price })
        else
          item_to_buy
        end
      end
    end
end
