class Checkout

  def initialize(promotion_rules)
    @total = 0.0
    @promotion_rules = promotion_rules
  end

  def scan(item)
    @total += item.price
  end

  def total
    @total
  end
end
