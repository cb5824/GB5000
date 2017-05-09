require 'csv'
require_relative 'ingredient'
require_relative 'recipe'
require_relative 'list'
######################################
# To-do
# 1) create method for generating menus
######################################

def generate_item_list
  items = []
  contents = CSV.open("ingredients.csv", "a+b", headers: true, header_converters: :symbol)
  contents.each do |row|
    if row[:isle] == nil || row[:isle] == ""
      items << Ingredient.new(row[:name])
    else
      items << Ingredient.new(row[:name],row[:isle])
    end
  end
  items
end

def generate_recipe_list
  recipes = []
  contents = CSV.open("recipes.csv", "a+b", headers: true, header_converters: :symbol)
  contents.each do |row|
    ingredients = row[:ingredients].split("+")
    quantities = row[:quantities].split("+")
    steps = row[:steps].split("+")
    ingredient_hash = {}
    ingredients.each_with_index do |ingredient,index|
      ingredient_hash[ingredient] = [($master_item_list.find {|item| item.name == ingredient }),quantities[index]]
    end
    recipes << Recipe.new(row[:name],ingredient_hash,steps)
  end
  recipes
end

def print_item_list(items)
  puts "\nItem...............................Isle" #31 so 35 from start
  items.each do |item|
    spaces=""
    (35-item.name.length).times do
      spaces += "."
    end
    puts "#{item.name}#{spaces}#{item.isle}"
  end
end

def check_for_blanks
  updated_contents = []
  contents = CSV.open("ingredients.csv", "a+b", headers: true, header_converters: :symbol)
  contents.each do |row|
    if row[:isle] == nil || row[:isle] == ""
      print "enter isle for #{row[:name]}(enter to skip): "
      row[:isle] = gets.chomp
    end
    updated_contents << row
  end

  CSV.open("ingredients.csv", "w") do |csv|
    csv << ["name","isle"]
    updated_contents.each do |row|
      csv << row
    end
  end
  gb5000_initialize
end

def add_item(name)
  if name != nil && name != ""
   CSV.open("ingredients.csv", "a") do |csv|
     csv<<[name]
   end
 end
end

def add_recipe(name,ingredients,quantities,steps)
  CSV.open("recipes.csv", "a") do |csv|
    csv << [name,ingredients,quantities,steps]
  end
end

def gb5000_initialize
  $master_item_list = generate_item_list
  $master_recipe_list = generate_recipe_list
end

###########################################################################
gb5000_initialize
list = List.new

puts "\nWelcome to Grocery-bot-5000!"

main_selection = "0"

while main_selection != "4"
  if ["0","1","2","3"].include?(main_selection) == false
  	puts "\nI’m sorry, that is an invalid selection\n"
  	main_selection = "0"
  else

    case main_selection
    when  "0"
      puts "
      ###########################\n
      ######## Main Menu ########\n
      ###########################\n
      1) Ingredients\n
      2) Recipes (not yet implemented)\n
      3) Lists (not yet implemented)\n
      4) Exit"
      print "\nSelection: "
      main_selection = gets.chomp
    when "1" #Main menu: Ingredients
      branch_selection = "0"
      while branch_selection != "3"
        puts "
        ###########################\n
        ####### Ingredients #######\n
        ###########################\n
        1) List stored ingredients\n
        2) Fill in blanks\n
        3) Back"
        print "\nSelection: "
        branch_selection = gets.chomp

        if ["0","1","2","3"].include?(branch_selection) == false
        	puts "\nI’m sorry, that is an invalid selection\n"
        	branch_selection = "0"
        else
          case branch_selection
          when "1"
            print_item_list($master_item_list)
            print "\nPress Enter to return"
            gets.chomp
            branch_selection = "0"
          when "2"
            check_for_blanks
            branch_selection = "0"
          end
        end
      end
      main_selection = "0"
    when "2" #Main menu: Recipes
      branch_selection = "0"
      while branch_selection != "3"
        puts "
        ###########################\n
        ######### Recipes #########\n
        ###########################\n
        1) List stored recipes\n
        2) Add new recipe\n
        3) Back"
        print "\nSelection: "
        branch_selection = gets.chomp

        if ["0","1","2","3"].include?(branch_selection) == false
        	puts "\nI’m sorry, that is an invalid selection\n"
        	branch_selection = "0"
        else
          case branch_selection
          when "1" #Recipe list
            recipe_selection = nil
            while recipe_selection != "0"
              puts "List of recipes:"
              $master_recipe_list.each_with_index do |recipe, index|
                puts "#{index + 1}) #{recipe.name}"
              end
              print "\nSelect a recipe to view or enter \"0\" to go return to the previous menu: "
              recipe_selection = gets.chomp
              if recipe_selection != "0"
                current_recipe = $master_recipe_list[(recipe_selection.to_i)-1]
                puts current_recipe.summary
                puts "\n(press ENTER to continue)"
                gets.chomp
                recipe_selection = "0"
              end
            end

            branch_selection = "0"
          when "2" #Add recipe
            print "\nEnter new recipe name: "
            name = gets.chomp
            ingredients = []
            quantities = []
            steps = []
            input = nil
            while input != ""
              print "\nEnter new recipe ingredient(or press enter to finish): "
              input = gets.chomp
              if input != ""
                ingredients << input
                if $master_item_list.find {|item| item.name == input } == nil
                  add_item(input)
                end
                print "\nEnter quantity of #{input}: "
                input = gets.chomp
                quantities << input
              end
            end
            input = nil
            while input != ""
              print "\nEnter next step for recipe(or press enter to finish): "
              input = gets.chomp
              if input != ""
                steps << input
              end
            end
            ingredients = ingredients.join("+")
            steps = steps.join("+")
            quantities = quantities.join("+")
            add_recipe(name,ingredients,quantities,steps)
            gb5000_initialize
            branch_selection = "0"
          end
        end
      end
      main_selection = "0"
    when "3" #Lists
      puts "
      ###########################\n
      ########## Lists ##########\n
      ###########################\n
      1) View current list\n
      2) Add recipe to list\n
      3) Add seperate item to list\n
      4) Print list\n
      5) Clear list\n
      6) Back"
            print "\nSelection: "
      branch_selection = gets.chomp

      if ["0","1","2","3","4","5","6"].include?(branch_selection) == false
        puts "\nI’m sorry, that is an invalid selection\n"
        branch_selection = "0"
      else
        case branch_selection
        when "1" #View current list
          puts list.summary
          print "\n(Press enter to continue)"
          gets.chomp
          branch_selection = "0"
        when "2" #Add recipe to list
          recipe_selection = nil
          while recipe_selection != "0"
            puts "List of recipes:"
            $master_recipe_list.each_with_index do |recipe, index|
              puts "#{index + 1}) #{recipe.name}"
            end
            print "\nSelect a recipe to add or enter \"0\" to go return to the previous menu: "
            recipe_selection = gets.chomp
            if recipe_selection != "0" && recipe_selection != nil
              current_recipe = $master_recipe_list[(recipe_selection.to_i)-1]
              list.recipes << current_recipe
            end
            branch_selection = "0"
          end
        when "3" #add seperate item to list
          print "\nEnter item to add to list: "
          item_name = gets.chomp
          print "\nEnter quantity of #{item_name}: "
          item_quantity = gets.chomp
          if $master_item_list.find {|item| item.name == item_name } == nil
            add_item(item_name)
            gb5000_initialize
          end
          list.other_items[item_name] = [($master_item_list.find {|item| item.name == item_name }),item_quantity]
          branch_selection = "0"
        when "4" #print list
          list.print
          branch_selection = "0"
        when "5" #clear
          list = List.new
          branch_selection = "0"
        end
      end
    end
  end
end
