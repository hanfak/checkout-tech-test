class Item
  attr_reader :product_code, :name, :price
  
  def initialize(options)
    @product_code = options[:product_code]
    @name = options[:name]
    @price = options[:price]
  end
end
