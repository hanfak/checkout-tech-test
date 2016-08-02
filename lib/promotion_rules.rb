class PromotionRules
  attr_reader :total_discount_limit

  def initialize( total_discount_limit = 0.0, total_discount = 0.0)
    @total_discount_limit = total_discount_limit
    @total_discount = total_discount
  end

  def total_discount
    return 0.0 if total_discount_limit == 0.0
    @total_discount
  end
end
