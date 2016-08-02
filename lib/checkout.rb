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
    apply_multibuy
    total = @basket.inject(0.0) {|sum, item| sum += item.price}
    discount = discount_amount(total) || 0.0
    total * (1 - discount)
  end

  private
    def discount_amount(total)
      @promotion_rules.total_discount if total >= @promotion_rules.total_discount_limit
    end

    def apply_multibuy
      count = @basket.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      toChange = @basket.select { |v| count[v] >=  2 && v == @promotion_rules.multibuy_item }[0]

      @basket.map! do |ele|
        if ele == toChange
          ele = Item.new({product_code:                                   toChange.product_code,                           name: toChange.name,                           price:                             @promotion_rules.multibuy_price })
        else
          ele
        end
      end
    end
end
