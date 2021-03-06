require_relative 'acceptance_helper'

feature 'Create question', '
  In order to get an answer from community
  As an authenticated user
  I want to be able to ask questions
' do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'
    click_on 'Save'

    expect(page).to have_content 'Your question has been successfully created.'
  end

  scenario 'Non-authenticated user tries to create question' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
