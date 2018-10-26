require_relative 'acceptance_helper'

feature 'Create answer', %q{
  In order to exchange my knowledge
  As an authenticated user
  I want to be able to answer the question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user creates answer' do

    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: 'text text'
    click_on 'Save'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'text text'
    end
  end

  scenario 'Non-authenticated user tries to create answer' do

    visit question_path(question)
    fill_in 'Your answer', with: 'text text'
    click_on 'Save'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  given!(:answer) { create(:answer, question_id: question.id) }

end