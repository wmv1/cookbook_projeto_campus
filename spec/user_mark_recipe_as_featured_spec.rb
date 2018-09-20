require 'rails_helper'

feature 'user mark recipe as feature' do
  scenario 'successfully' do
    user = User.create(email: 'teste@teste.com', password: '1234567890')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user:  user)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end

    
    click_on 'Bolo de cenoura'
    click_on 'Marcar como destaque'

    expect(page).to have_content('Receita marcada como destaque com sucesso!')
    expect(page).to have_css("img[src*='star']")
  end

  scenario 'and they appear differently' do

    user = User.create(email: 'teste@teste.com', password: '1234567890')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    principal_recipe_type = RecipeType.create(name: 'Prato principal')
    featured_recipe = Recipe.create(title: 'Bolo de cenoura',
                                    difficulty: 'Médio',
                                    recipe_type: recipe_type,
                                    cuisine: cuisine,
                                    cook_time: 50,
                                    ingredients: 'Farinha, açucar, cenoura',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                                    featured: true,
                                     user: user)

    another_recipe = Recipe.create(title: 'Feijoada',
                                   recipe_type: principal_recipe_type,
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes',
                                   user: user)
    visit root_path
    
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end

    expect(page).to have_css('h3', text: 'Receitas destaque')
    within '#recipes-featured' do
      expect(page).to have_content(featured_recipe.title)
      expect(page).to have_css("img[src*='star']")
    end
    expect(page).to have_css('h3', text: 'Outras receitas')
    within '#other-recipes' do
      expect(page).to have_content(another_recipe.title)
    end
  end
end
