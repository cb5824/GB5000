class List

  attr_accessor :recipes, :other_items

  def initialize(recipes = [], other_items = {})
    @recipes = recipes
    @other_items = other_items
  end

  def summary
    items = []
    @recipes.each do |recipe|
      recipe.ingredients.each do |name, array|
        items << array
      end
    end
    @other_items.each do |item, array|
      items << array
    end
    items = items.sort_by {|item| item[0].isle.nil? ? 0 : item[0].isle.to_i}

    summary = "\nItem.....................Amount....Isle" #25, 10
    items.each do |item|
      name = item[0].name
      amount = item[1]
      isle = item[0].isle
      if isle == nil || isle == ""
        isle = "[___]"
      end
      spaces1 = ""
      spaces2 = ""
      (25-name.length).times do
        spaces1 += "."
      end
      (10-amount.length).times do
        spaces2 += "."
      end
      summary << "\n#{name}#{spaces1}#{amount}#{spaces2}#{isle}"
    end
    summary
  end

  def print
    File.open("list.txt", "w") do |f|
      f.puts summary #replace this with printed list obviously
    end
    file_to_open = "list.txt"
    system %{cmd /c "start #{file_to_open}"}
  end
end
