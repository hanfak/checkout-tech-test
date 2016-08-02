class Checkout

  def initialize(promotion_rules)
    @total = 0.0
    @promotion_rules = promotion_rules
  end

  def scan(item)
    @total += item.price
  end

  def total
    discount = discount_amount || 0.0
    @total * (1 - discount)
  end

  private
    def discount_amount
      @promotion_rules.total_discount if @total >= @promotion_rules.total_discount_limit
    end
end
