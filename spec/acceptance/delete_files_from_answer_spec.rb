require_relative 'acceptance_helper'

feature 'Delete files from answer', "
  In order to change illustration to my answer
  As an answer's author
  I'd like to be able to delete files
" do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }
  given!(:attachment) { create(:attachment, attachable: answer) }

  scenario 'Author deletes a file when changing an answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_link("edit-btn-answer-#{answer.id}")
    click_on 'remove file', class: 'remove_fields existing'

    expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'Authenticated user deletes foreign answers file' do
    sign_in(user2)
    visit question_path(question)
    expect(page).to_not have_content 'Edit question'
  end

  scenario 'Non-authenticated user tries to delete answers file' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit question_path(question)

    expect(page).to_not have_content 'edit'
  end
end
