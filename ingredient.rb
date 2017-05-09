
class Ingredient
  attr_accessor :price, :isle
  attr_reader :name

  def initialize(name, isle = nil)
  @name = name
  @isle = isle
  end

end
