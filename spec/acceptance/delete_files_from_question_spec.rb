require_relative 'acceptance_helper'

feature 'Delete files from question', %q{
  In order to change illustration to my question
  As an question's author
  I'd like to be able to delete files
} do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:attachment) { create(:attachment, attachable_id: question.id, attachable_type: 'Question') }

  background do
    sign_in(user)
    visit edit_question_path(question)
  end

  scenario 'Author deletes a file when changing a question' do
    click_on 'remove file'

    expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'Authenticated user deletes foreign questions file' do
    sign_in(user2)
    visit edit_question_path(question)
    expect(page).to_not have_content 'remove file'
  end

  scenario 'Non-authenticated user tries to delete questions file' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit edit_question_path(question)

    expect(page).to_not have_content 'remove file'
  end
end



