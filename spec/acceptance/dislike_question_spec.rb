require_relative 'acceptance_helper'

feature 'Dislike the question', '
  In order to vote for the question
  As an authenticated user
  I want to be able to dislike the question
' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }

  scenario 'Authenticated user dislikes the question', js: true do
    sign_in(user2)
    visit question_path(question)
    click_on 'Dislike it'
    click_on 'Dislike it'
    expect(page).to have_content '1'
  end

  scenario 'Author dislikes own question', js: true do
    sign_in(user)
    visit question_path(question)
    expect(page).to_not have_content 'Dislike it'
  end
end
