require_relative 'acceptance_helper'

feature 'Comet answer', '
  In order to see new answers
  As an user
  I want to be able to see all of answers without rendering page
' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user sees new answer' do
    sign_in(user2)
    visit question_path(question)
    within '.answers' do
      expect(page).to have_content 'MyAnswer'
    end
  end
end
