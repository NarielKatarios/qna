require_relative 'acceptance_helper'

feature 'Edit question', "
  In order to fix mistake
  As an author of question
  I'd like to be able to edit my question
" do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }

  scenario 'Authenticated user edits own question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Edit'
    fill_in 'Title', with: 'edited title'
    fill_in 'Body', with: 'edited body'
    click_on 'Save'

    expect(page).to_not have_content question.title
    expect(page).to_not have_content question.body
    expect(page).to have_content 'edited title'
    expect(page).to have_content 'edited body'
    expect(page).to_not have_selector 'textfield'
  end

  scenario 'Authenticated user tries to edit foreign question' do
    sign_in(user2)

    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  scenario 'Non-authenticated user tries to edit question' do
    User.create!(email: 'user@test.com', password: '12345678')
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end
end
