require_relative 'acceptance_helper'

feature 'Add files to answer', "
  In order to illustrate my answer
  As an answer's author
  I'd like to be able to attach files
" do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User attaches a file when giving an answer', js: true do
    fill_in 'Your answer', with: 'My answer'

    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Save answer'

    within '.answers' do
      expect(page).to have_link '', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end
