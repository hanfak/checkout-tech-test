class PromotionRules
  attr_reader :total_discount_limit, :multibuy_item, :multibuy_price, :multibuy_amount

  def initialize( options = {})
    @total_discount_limit = options[:total_discount_limit] || 0.0
    @total_discount = options[:total_discount] || 0.0
    @multibuy_item = options[:multibuy_item] || nil
    @multibuy_price = options[:multibuy_price] || 0.0
    @multibuy_amount = options[:multibuy_amount] || 2
  end

  def total_discount
    return 0.0 if total_discount_limit <= 0.0
    @total_discount
  end
end
