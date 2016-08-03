class Checkout
  def initialize(promotion_rules, basket = Basket.new(promotion_rules))
    @promotion_rules = promotion_rules
    @basket = basket
  end

  def scan(item)
    basket.add(item)
  end

  def total
    basket.apply_multibuy
    subTotal = basket.scanned_items.inject(0.0) { |sum, item| sum += item.price }
    (subTotal * discount_amount(subTotal)).round(2)
  end

  private
    attr_reader :promotion_rules, :basket

    def discount_amount(total)
      total >= promotion_rules.total_discount_limit ? (1.0 - promotion_rules.total_discount) : 1.0
    end
end
