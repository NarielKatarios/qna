require_relative 'acceptance_helper'

feature 'Dislike the answer', '
  In order to vote for the answer
  As an authenticated user
  I want to be able to dislike the answer
' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user2.id) }

  scenario 'Authenticated user dislikes the answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Dislike this answer'
    click_on 'Dislike this answer'
    expect(page).to have_content '1'
  end

  scenario 'Author dislikes own answer', js: true do
    sign_in(user2)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_content 'Dislike'
    end
  end
end
