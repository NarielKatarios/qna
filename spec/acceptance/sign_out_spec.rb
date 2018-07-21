require_relative 'acceptance_helper'

feature 'User sign out', %q{
  In order to be able to exit
  As a User
  I want to be able to sign out
} do

  given!(:user) { create(:user) }

  scenario 'Registered user tries to sign out' do

    sign_in(user)
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end