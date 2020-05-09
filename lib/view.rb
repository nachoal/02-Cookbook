class View

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}"
    end
  end

  def ask_for_recipe_name
    puts "Whats the new recipe name?"

    gets.chomp
  end

  def ask_for_recipe_description
    puts "Whats the new recipe description?"

    gets.chomp
  end

  def ask_for_recipe_index
    puts 'Whats the recipe that you want to delete?'

    gets.chomp.to_i - 1
  end

  def ask_for_ingredient
    puts 'Whats the ingredient that you want to search for'

    gets.chomp
  end

  def display_loading(ingredient)
    puts "Looking for #{ingredient} recipes on the Internet..."
  end
end