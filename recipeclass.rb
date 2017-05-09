
class Recipe
  attr_reader :name, :ingredients

  def initialize (name)
    @name = name
    @ingredients = {}
    @instructions = []
  end

  def add_ingredients(i_list)
    i_list.each do |i_name|
      print "\nQuantity of #{i_name}: "
      i_quantity = gets.chomp
      if $master_ingredient_list.include?(i_name)
        @ingredients[i_name] = [$master_ingredient_list[i_name],i_quantity]
      else
      new_ingredient = Ingredient.new(i_name)
      $master_ingredient_list[i_name] = new_ingredient
      @ingredients[i_name] = [new_ingredient,i_quantity]
      end
    end

  end

  def remove_ingredients
  end

  def enter_instructions
    puts "\nInstructions for #{@name}"
    next_step = "blank"
    step_number = 1
    while next_step.downcase != "done"
      print "\nPlease enter step #{step_number} (or enter \"done\" to finish): "
      next_step = gets.chomp
      @instructions << next_step
      step_number += 1
    end
    summary
  end

  def summary
    puts "\nIngredients:"
    @ingredients.each do |name, array|
      puts "#{name} - #{array[1]}"
    end
    puts "\nInstructions:"
    @instructions.each_with_index do |text, step|
      puts "#{step + 1}) #{text}"
    end
  end
end
