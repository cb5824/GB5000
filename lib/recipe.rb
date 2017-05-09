
class Recipe
  attr_reader :name, :ingredients, :steps

  def initialize (name,ingredients,steps)
    @name = name
    @ingredients = ingredients
    @steps = steps
  end

  def add_ingredients(item)
    @ingredients << item
  end



  def remove_ingredients
  end

  def enter_instructions(steps)
    @steps = steps
  end

  def summary
    summary = ""
    summary << "\nIngredients:"
    @ingredients.each do |name, array|
      summary << "\n#{name} - #{array[1]}"
    end
    summary << "\n\nInstructions:"
    @steps.each_with_index do |text, step|
      summary << "\n#{step + 1}) #{text}"
    end
    summary
  end
end
