require_relative 'acceptance_helper'

feature 'Delete question', '
  In order to delete the question
  As an authenticated user
  I want to be able to destroy questions
' do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }

  scenario 'Authenticated user deletes own question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'Your question has been deleted.'
  end

  scenario 'Authenticated user deletes foreign question' do
    sign_in(user2)
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
  end

  scenario 'Non-authenticated user tries to delete question' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit question_path(question)

    # expect(page).to have_content "You can not delete #{question.title}"
    expect(page).to_not have_content 'Delete'
  end
end
