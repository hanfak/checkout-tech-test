class Checkout
  def initialize(promotion_rules)
    @total = 0.0
    @promotion_rules = promotion_rules
    @basket = []
  end

  def scan(item)
    @basket << item
  end

  def total
    apply_multibuy(promotion_rules.multibuy_item)
    subTotal = @basket.inject(0.0) { |sum, item| sum += item.price }
    (subTotal * discount_amount(subTotal)).round(2)
  end

  private
    attr_reader :promotion_rules

    def discount_amount(total)
      total >= promotion_rules.total_discount_limit ? (1.0 - promotion_rules.total_discount) : 1.0
    end

    def apply_multibuy(item)
      change_price_of_multibuy_items(item) if match_multibuy_criteria(item)
    end

    def match_multibuy_criteria(item)
      @basket.include?(item) && @basket.count(item) >=  promotion_rules.multibuy_amount
    end

    def change_price_of_multibuy_items(item)
      @basket.map! do |item_to_buy|
        if item_to_buy == item
          item_to_buy = Item.new({ product_code: item.product_code, name: item.name, price: promotion_rules.multibuy_price })
        else
          item_to_buy
        end
      end
    end
end
