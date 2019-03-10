require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like to be able to edit my answer
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }


  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do

    scenario "sees link to Edit" do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        expect(page).to have_link 'Edit'
      end
    end

    scenario 'tries to edit his answer', js: true do
      sign_in(user)
      visit question_path(question)
      within '.answers' do
        click_on 'Edit'
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save answer'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
      end
    end

    scenario "tries to edit other user`s question" do
      sign_in(user2)
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end