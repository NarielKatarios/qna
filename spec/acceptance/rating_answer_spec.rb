require_relative 'acceptance_helper'

feature 'Rating of the answer', %q{
  In order to see the rating of the answer
  As an user
  I want to be able to see the rating of the answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question_id: question.id ) }
  given!(:like_vote) { create(:vote, user: user2, votable: answer, like: true, dislike: false ) }
  given!(:like_vote) { create(:vote, user: user2, votable: answer, like: true, dislike: false ) }
  given!(:like_vote) { create(:vote, user: user2, votable: answer, like: true, dislike: false ) }

  scenario ' User sees the rating of the answer', js: true do
    sign_in(user)
    visit question_path(question)
    byebug
    click_on 'Like this answer'
    sleep 1
    expect(page).to have_content 'Like: 4'
  end
end