class RecipeScrapper # or ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    # 2. Search bbc food for that ingredient
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{@keyword}"
    doc = Nokogiri::HTML(open(url).read)
    # 3. Get the first 5 recipes info
    recipe_elements = doc.search(".node-recipe.node-teaser-item").first(5)
    
    # 4. with that info create recipe instances
    recipe_elements.map! do |recipe_element|
      name        = recipe_element.search('.teaser-item__title').text.strip
      description = recipe_element.search('.teaser-item__text-content').text
      recipe = Recipe.new(name, description)

      recipe
    end

    # Return the list of recipes that we wound
    recipe_elements
  end
end