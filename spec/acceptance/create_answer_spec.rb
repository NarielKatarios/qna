require_relative 'acceptance_helper'

feature 'Create answer', '
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to answer the question
' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'text text'
    click_on 'Save answer'

    within '.answers' do
      expect(page).to have_content 'text text'
    end
  end

  scenario 'Non-authenticated user tries to create answer', js: true do
    visit question_path(question)
    expect(page).to_not have_selector 'Your answer'
    expect(page).to_not have_content 'Save answer'
  end
end
