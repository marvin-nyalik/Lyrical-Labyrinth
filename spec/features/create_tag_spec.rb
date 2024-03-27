require 'rails_helper'

RSpec.describe 'Create Tag', type: :feature do
  before(:each) do
    FactoryBot.create(:user, email: 'user2@example.com', password: 'password', admin: true)
    visit new_user_session_path
    fill_in 'Email', with: 'user2@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  it 'Allows Admin user to add tags for Article classification' do
    expect(page).to have_content 'Signed in successfully.'
    page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
    click_link('add_tag')
    expect(page).to have_content 'Add New Tag'
    fill_in 'name_field', with: 'Tag1'
    fill_in 'desc_field', with: 'Tag1 Desc'
    click_button 'Create Tag'
    sleep(1)
    expect(page).to have_content 'Tag - Tag1 successfully created'
  end

  it 'Fails to create a tag without a name' do
    expect(page).to have_content 'Signed in successfully.'
    page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
    click_link('add_tag')
    expect(page).to have_content 'Add New Tag'
    fill_in 'desc_field', with: 'Tag1 Desc'
    click_button 'Create Tag'
    sleep(1)
    expect(page).to have_css('input:invalid')
  end

  it 'Fails to create tag without a description' do
    expect(page).to have_content 'Signed in successfully.'
    page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
    click_link('add_tag')
    expect(page).to have_content 'Add New Tag'
    fill_in 'name_field', with: 'Tag1 Name'
    click_button 'Create Tag'
    sleep(1)
    expect(page).to have_current_path(new_tag_path)
  end
end
