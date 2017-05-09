
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

  end

  def remove_ingredients
  end

  def enter_instructions(steps)
    @steps = steps
  end

  def summary
    puts "\nIngredients:"
    @ingredients.each do |name, array|
      puts "#{name} - #{array[1]}"
    end
    puts "\nInstructions:"
    @steps.each_with_index do |text, step|
      puts "#{step + 1}) #{text}"
    end
  end
end
