require_relative 'acceptance_helper'

feature 'Create comment', %q{
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to comment questions and answers
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer) }

  scenario 'Authenticated user creates question\'s comment', js: true do

    sign_in(user)
    visit question_path(question)
    fill_in 'Questions comment', with: 'text text'
    click_on 'Save questions comment'

    within '.comments' do
      expect(page).to have_content 'text text'
    end
  end
end