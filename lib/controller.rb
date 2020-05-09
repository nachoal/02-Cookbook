require_relative 'view'
require_relative 'recipe'
require_relative 'recipe_scrapper'
require 'open-uri'
require 'nokogiri'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view     = View.new
  end

  def list
    # 1. Ask cookbook for list of recipes
    recipes = @cookbook.all
    # 2. pass the recipes to the view and display
    @view.display(recipes)  
  end

  def create
    # 1. Ask the user for info to create recipe
    # 1.1 Ask for name
    name = @view.ask_for_recipe_name
    # 1.2 Ask for description
    description = @view.ask_for_recipe_description
    # 2. Create a recipe instance
    recipe = Recipe.new(name, description)
    # 3. Save into repository
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 1. Ask user to select recipe to delete
    index = @view.ask_for_recipe_index

    @cookbook.remove_recipe(index)
  end

  def parse
    # 1. Ask the user for ingredient to search
    ingredient = @view.ask_for_ingredient
    @view.display_loading(ingredient)
    recipe_elements = RecipeScrapper.new(ingredient).call
    # 5. Show the user list of recipes for her to select one
    @view.display(recipe_elements)
    # 6. Get the user option (recipe index)
    index = @view.ask_for_recipe_index
    recipe_to_save = recipe_elements[index]
    # 7. Add that recipe to cookbook
    @cookbook.add_recipe(recipe_to_save)
  end
end