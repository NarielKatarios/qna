require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete an answer to the question
  As an authenticated user
  I want to be able to destroy the answer
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user deletes answer' do

    sign_in(user)
    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'Your answer has been successfully deleted.'
  end

  scenario 'Authenticated user deletes foreign answer' do

    sign_in(user)

    visit questions_path
    click_on 'Delete'

    expect(page).to have_content 'You can delete only your answers'
  end

  scenario 'Non-authenticated user tries to delete answer' do

    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end