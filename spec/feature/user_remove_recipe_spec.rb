require 'rails_helper'

feature 'User remove recipe' do

  scenario 'successfully' do

    user = User.create(email: 'teste@teste.com', password: '1234567890')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end

    within "#recipe-#{recipe.id}" do 
      click_on 'Apagar'
    end
               


  end

  scenario 'and user is not the owner' do

    owner = User.create(email: 'teste@teste.com', password: '1234567890')
    regular_user = User.create(email: 'teste@teste2.com', password: '1234567890')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: owner)

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste2.com'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end
    
    expect(page).not_to have_link('Apagar')
    
  end


end
