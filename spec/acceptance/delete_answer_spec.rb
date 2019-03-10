require_relative 'acceptance_helper'

feature 'Delete answer', '
  In order to delete an answer to the question
  As an authenticated user
  I want to be able to destroy the answer
' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'Authenticated user deletes own answer', js: true do
    sign_in(user)
    visit question_path(question)
    page.accept_alert 'Are you sure?' do
      click_on 'Delete answer'
    end

    expect(page).to_not have_content 'MyAnswer'
  end

  scenario 'Authenticated user deletes foreign answer' do
    sign_in(user2)

    visit question_path(question)

    expect(page).to_not have_content 'Delete'
  end

  scenario 'Non-authenticated user tries to delete answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete'
  end
end
