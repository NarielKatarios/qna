require 'rails_helper'

feature 'Answers_list', %q{
  In order to see the information in the answers
  As an authenticated user
  I want to be able to see the questions and the answers to them
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'User sees the list of answers to the question' do
    sign_in (user)
    visit question_path(question)

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'MyAnswer'
  end
end