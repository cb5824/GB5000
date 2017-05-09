require 'csv'
require_relative "ingredient"

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

def print_item_list(items)
  puts "Item...............................Isle" #31 so 35 from start
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
end

def add_item(name)
  if name != nil && name != ""
   CSV.open("ingredients.csv", "a") do |csv|
     csv<<[name]
   end
 end
end

def add_recipe(name,ingredients,steps)#need to update recipe class to fit this
  CSV.open("recipes.csv", "a") do |csv|
    csv << Recipe.new(name,ingredients,steps)
  end
end
###########################################################################

master_item_list = generate_item_list

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
    when "1"
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
            print_item_list(master_item_list)
            print "\nPress Enter to return"
            gets.chomp
            branch_selection = "0"
          when "2"
          end
        end
      end
      main_selection = "0"
    end
  end
end
