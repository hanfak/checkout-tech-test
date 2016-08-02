class Checkout

  def scan(item)
    @total = item.price
  end

  def total
    @total || 0.0
  end
end
