class Checkout

  def initialize(promotion_rules)
    @total = 0.0
    @promotion_rules = promotion_rules
  end

  def scan(item)
    @total += item.price
  end

  def total
    return @total * (1 - @promotion_rules.total_discount)
  end
end
