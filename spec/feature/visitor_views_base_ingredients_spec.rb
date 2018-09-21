require 'rails_helper'

feature 'Visitor views base ingredients' do
  scenario 'successfully' do
    user = User.create(email: 'teste@teste.com', password: '1234567890')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)
    cenoura = BaseIngredient.create(name: 'Cenoura')
    farinha = BaseIngredient.create(name: 'Farinha')
    BaseIngredientRecipe.create(recipe: recipe, base_ingredient: cenoura)
    BaseIngredientRecipe.create(recipe: recipe, base_ingredient: farinha)

    visit root_path
    click_on 'Bolo de cenoura'

    expect(page).to have_css('p', text: 'Cenoura')
    expect(page).to have_css('p', text: 'Farinha')
 

  
  
  end
end
