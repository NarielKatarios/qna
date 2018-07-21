require 'rails_helper'

feature 'Questions_list', %q{
  In order to see the questions of community
  As an authenticated user
  I want to be able to see the list of questions
} do


  scenario 'User sees the list of questions' do

    visit questions_path
    expect(page).to have_content 'Questions list'
    #save_and_open_page
  end
end