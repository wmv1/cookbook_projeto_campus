require 'rails_helper'

feature 'User attach photo to recipe' do

  scenario 'sucessfully' do
    user = User.create(email: 'teste@teste.com.br', password: '1234567890')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Arabe')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end

    click_on 'Enviar uma receita'


    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file('Foto da Receita', Rails.root.join('spec', 'support', 'fixtures', 'feijoada.jpg'))

    click_on 'Enviar'

    expect(page).to have_xpath("//img[contains(@src,'feijoada.jpg')]")
  end

  scenario 'and doesnt uploud image' do
    user = User.create(email: 'teste@teste.com.br', password: '1234567890')
    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end

    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'

    click_on 'Enviar'

    expect(page).to have_xpath("//img[contains(@src,'missing.png')]")
  end


  scenario 'and is not an image' do
    user = User.create(email: 'teste@teste.com.br', password: '1234567890')
    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')

    visit root_path
   click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end


    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    attach_file('Foto da Receita', Rails.root.join('spec', 'support', 'fixtures', 'file.txt'))

    click_on 'Enviar'

    expect(page).to have_content('Tipo da imagem não é válido')
  end
end
