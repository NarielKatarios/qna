require_relative 'acceptance_helper'

feature 'Delete answer', %q{
  In order to delete an answer to the question
  As an authenticated user
  I want to be able to destroy the answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'Authenticated user deletes own answer' do

    sign_in(user)
    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'Your answer has been successfully deleted.'
  end

  scenario 'Authenticated user deletes foreign answer' do

    sign_in(user2)

    visit question_path(question)

    #expect(page).to have_content "You can not delete #{answer.body}"
    expect(page).to_not have_content 'Delete'
  end

  scenario 'Non-authenticated user tries to delete answer' do

    visit question_path(question)

    #expect(page).to have_content "You can not delete #{answer.body}"
    expect(page).to_not have_content 'Delete'
  end
end