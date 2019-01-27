require_relative 'acceptance_helper'

feature 'Like the answer', %q{
  In order to vote for the answer
  As an authenticated user
  I want to be able to like the answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user2.id) }
  given!(:answer2) { create(:answer, question_id: question.id, user_id: user2.id) }

  scenario 'Authenticated user likes the answer', js: true do
    sign_in(user)
    visit question_path(question)
    within '.answers' do
      click_on 'Like', id: "like-btn-answer-#{answer2.id}"
      sleep 1
      click_on 'Like', id: "like-btn-answer-#{answer2.id}"
      sleep 1
      expect(page).to have_content '101'
    end
  end

  scenario 'Author likes own answer', js: true do
    sign_in(user2)
    visit question_path(question)
    within '.answers' do
     expect(page).to_not have_css("#like-btn-answer-#{answer2.id}")
    end
  end
end