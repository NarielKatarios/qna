require_relative 'acceptance_helper'

feature 'Comet question', '
  In order to see new questions
  As an user
  I want to be able to see all of questions without rendering page
' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Authenticated user sees new question' do
    sign_in(user2)
    visit question_path(question)

    expect(page).to have_content 'MyText'
  end
end
