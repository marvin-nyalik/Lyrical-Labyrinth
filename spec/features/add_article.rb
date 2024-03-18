require 'rails_helper'

RSpec.describe 'Add Article', type: :feature do
  before(:each) do
    user = FactoryBot.create(:user, email: 'user2@example.com', password: 'password', admin: true)
    visit new_user_session_path
    fill_in 'Email', with: 'user2@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  it 'Allows Admin users to publish articles' do
    expect(page).to have_content 'Signed in successfully.'
    click_link 'add_article_link'
    expect(page).to have_current_path(new_post_path)
    fill_in 'photo_url', with: 'http://photo.com/1'
    fill_in 'summary_field', with: 'Post summary'
    fill_in 'title_field', with: 'Post title'

    within('div#body_field') do
      find('.test-class').send_keys 'Body data'
    end
  end
end