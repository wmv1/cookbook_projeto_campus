require 'rails_helper'

feature 'Admin view users list' do
  scenario 'sucessfully' do
    admin = User.create(email: 'admin@teste.com', password: '1234567890', admin: true)
    regular_user = User.create(email: 'teste@teste.com', password: '1234567890', admin: false)

  visit root_path

  click_on 'Entrar'
  fill_in 'Email', with: 'admin@teste.com'
  fill_in 'Password', with: '1234567890'
  within 'form' do 
    click_on 'Enviar'
  end

puts current_path

  click_on 'Usuários'

  expect(page).to have_css('h1', text:'teste@teste.com')

    




  end
end