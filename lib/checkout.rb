class Checkout

  def initialize(promotion_rules)
    @total = 0.0
    @promotion_rules = promotion_rules
    @discount = 0.0
  end

  def scan(item)
    @total += item.price
  end

  def total
    if @total >= @promotion_rules.total_discount_limit
      @discount = @promotion_rules.total_discount
    end
    @total * (1 - @discount)
  end
end
