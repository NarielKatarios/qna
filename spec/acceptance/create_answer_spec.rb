require 'rails_helper'

feature 'Create answer', %q{
  In order to give an answer to the question
  As an authenticated user
  I want to be able to answer the question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user creates answer' do

    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'text text'
    click_on 'Create Answer'

    expect(page).to have_content 'text text'
  end

  scenario 'Non-authenticated user tries to create answer' do

    visit question_path(question)
    fill_in 'Your answer', with: 'text text'
    click_on 'Create Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'User tries to create an invalid answer' do

    sign_in(user)
    visit question_path(question)

    click_on 'Create'

    expect(page).to have_content 'Need text'
  end
end