require 'rails_helper'

RSpec.describe 'User authentication', type: :feature do
  it 'Allows User sign up' do
    visit new_user_registration_path
    fill_in 'email_field', with: 'user@example.com'
    fill_in 'avatar_field', with: 'https://twitter.com/users/avatar.jpg'
    fill_in 'full_name_field', with: 'Ochieng Antonio'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_current_path(root_path)
  end

  it 'allows user log in and view articles' do
    FactoryBot.create(:user, email: 'user2@example.com', password: 'password')
    visit new_user_session_path
    fill_in 'Email', with: 'user2@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path(root_path)
  end
end
