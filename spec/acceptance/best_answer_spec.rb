require_relative 'acceptance_helper'

feature 'Best answer', '
  In order to choose the best answer to the question
  As an author of the question
  I want to be able to mark best answer
' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'Author of the question marks best answer' do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Make this answer the best'
    end
    # save_and_open_page
    expect(page).to have_content 'best answer'
    expect(page).to_not have_selector 'check_box'
  end
end
