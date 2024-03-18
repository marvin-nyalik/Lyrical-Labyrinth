require 'rails_helper'

RSpec.describe 'Add Article', type: :feature do
    before(:each) do
      user = FactoryBot.create(:user, email: 'user2@example.com', password: 'password', admin: true)
      visit new_user_session_path
      fill_in 'Email', with: 'user2@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end

    it 'Allows Admin user to register category with both name and description' do
      expect(page).to have_content 'Signed in successfully.'
      page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
      click_link('add_category')      
      expect(page).to have_content 'Add New Category'
      fill_in 'name_field', with: 'Category1'
      fill_in 'desc_field', with: 'Category1 Desc'
      click_button 'Create Category'
      expect(page).to have_content 'Category Category1 added'
    end

    it 'Fails to create category without a name' do
        expect(page).to have_content 'Signed in successfully.'
        page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
        click_link('add_category')      
        expect(page).to have_content 'Add New Category'
        fill_in 'desc_field', with: 'Category1 Desc'
        click_button 'Create Category'
        expect(page).to have_css('input:invalid')
        expect(page).to have_current_path(new_category_path)
    end

    it 'Fails to create category without a description' do
        expect(page).to have_content 'Signed in successfully.'
        page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
        click_link('add_category')      
        expect(page).to have_content 'Add New Category'
        fill_in 'name_field', with: 'Category1'
        click_button 'Create Category'

        expect(page).to have_current_path(new_category_path)
    end
end