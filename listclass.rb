class List
  def initialize(recipes)
  end

  def print
    File.open("test.txt", "w") do |f|
    f.puts "Hello world" #replace this with printed list obviously
  end
  end
end