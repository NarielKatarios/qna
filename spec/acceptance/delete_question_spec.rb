require 'rails_helper'

feature 'Delete question', %q{
  In order to delete the question
  As an authenticated user
  I want to be able to destroy questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user deletes own question' do

    sign_in(user)

    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'Your question has been successfully deleted.'
  end

  scenario 'Authenticated user deletes foreign question' do

    sign_in(user)

    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'You can delete only your questions'
  end

  scenario 'Non-authenticated user tries to delete question' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end