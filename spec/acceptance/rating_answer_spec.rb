require_relative 'acceptance_helper'

feature 'Rating of the answer', %q{
  In order to see the rating of the answer
  As an user
  I want to be able to see the rating of the answer
} do

  given(:user) { create(:user) }
  given(:user1) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question_id: question.id, user: user ) }
  given!(:like_vote) { create(:vote, user: user2, votable: answer, like: true, dislike: false ) }
  given!(:like_vote) { create(:vote, user: user2, votable: answer, like: true, dislike: false ) }

  scenario ' User sees the rating of the answer', js: true do
    sign_in(user1)
    visit question_path(question)
    within '.answers' do
      click_on 'Like this answer', id: "like-btn-answer-#{answer.id}"
      sleep 1
      click_on 'Like this answer', id: "like-btn-answer-#{answer.id}"
      sleep 1
      expect(page).to have_content '202'
    end
  end
end