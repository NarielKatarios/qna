require 'rails_helper'

feature 'User authenticates', %q{
  In order to be able to sign in
  As an authenticated User
  I want to be able to authenticate
} do

  scenario 'Non-Registered user tries to authenticate' do
    visit new_user_session_path
    click_on 'Sign up'
    fill_in 'Email', with: 'user.email@mail.ru'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end
end