require 'rails_helper'

feature 'User autenticate' do 

  scenario 'sucessfully' do
    #dados 
    User.create(email: 'teste@teste.com.br', password: '1234567890')

    #navegacao
    
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end
    #expectativas
    expect(current_path).to eq root_path
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_content "Olá teste@teste.com.br"
    expect(page).to have_link 'Sair'



  end

  scenario 'and user lougout' do
    #dados 
    User.create(email: 'teste@teste.com.br', password: '1234567890')

    #navegacao
    
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Password', with: '1234567890'
    within 'form' do 
      click_on 'Enviar'
    end
    click_on 'Sair'
    #expectativas

    expect(current_path).to eq root_path
    expect(page).not_to have_content "Olá teste@teste.com.br"
    expect(page).not_to have_link 'Sair'
    expect(page).to have_link 'Entrar'
    
    
   
  end

  



end
    
    


