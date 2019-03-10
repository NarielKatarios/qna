require_relative 'acceptance_helper'

feature 'Like the question', '
  In order to vote for the question
  As an authenticated user
  I want to be able to like the question
' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  # given(:like_vote) { create(:vote, user_id: user2.id, like: true, dislike: false ) }
  # given(:dislike_vote) { create(:vote, user_id: user2.id, like: false, dislike: true ) }
  given(:question) { create(:question, user_id: user.id) }

  scenario 'Authenticated user likes the question', js: true do
    sign_in(user2)
    visit question_path(question)
    click_on 'Like it'
    click_on 'Like it'
    expect(page).to have_content '1'
  end

  scenario 'Author likes own question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to_not have_content 'Like it'
  end

  scenario 'Authenticated user likes the question second time', js: true do
    sign_in(user2)
    visit question_path(question)
    click_on 'Like it'
    click_on 'Like it'
    click_on 'Like it'
    click_on 'Like it'
    expect(page).to have_content '0'
  end

  scenario ' User sees the rating of the question', js: true do
    visit question_path(question)
    expect(page).to have_content '0'
  end
end
