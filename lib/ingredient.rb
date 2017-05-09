
class Ingredient
  attr_accessor :price, :isle
  attr_reader :name

  def initialize(name, isle = nil, price = nil)
  @name = name
  @isle = isle
  @price = price
  end

end
