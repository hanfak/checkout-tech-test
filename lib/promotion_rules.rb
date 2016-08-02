class PromotionRules
  attr_reader :total_discount_limit

  def initialize( options = {})
    @total_discount_limit = options[:total_discount_limit] || 0.0
    @total_discount = options[:total_discount]
  end

  def total_discount
    return 0.0 if total_discount_limit <= 0.0
    @total_discount
  end
end
