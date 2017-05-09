require 'csv'
require_relative "../ingredient"

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
