require 'rails_helper'

RSpec.describe 'Add Comment', type: :feature do
  before(:each) do
    user = FactoryBot.create(:user, email: 'user2@example.com', password: 'password', admin: true)
    visit new_user_session_path
    fill_in 'Email', with: 'user2@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'

    page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
    click_link('add_tag')      
    expect(page).to have_content 'Add New Tag'
    fill_in 'name_field', with: 'Tag1'
    fill_in 'desc_field', with: 'Tag1 Desc'
    click_button 'Create Tag'
    sleep(1)
    expect(page).to have_content 'Tag - Tag1 successfully created'

    page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
    click_link('add_category')      
    expect(page).to have_content 'Add New Category'
    fill_in 'name_field', with: 'Category1'
    fill_in 'desc_field', with: 'Category1 Desc'
    click_button 'Create Category'
    expect(page).to have_content 'Category Category1 added'

    page.execute_script("document.querySelector('p.notice.tip').style.visibility = 'hidden'")
    click_link 'add_article_link'
    expect(page).to have_current_path(new_post_path)
    fill_in 'photo_url', with: 'https://images.pexels.com/photos/1615776/pexels-photo-1615776.jpeg?auto=compress&cs=tinysrgb&w=600'
    fill_in 'summary_field', with: 'Post summary'
    fill_in 'title_field', with: 'Post title'
    select(Category.first.name, from: 'category_id')
    find('#tag_ids').set(true)

    within('div#body_field') do
      find('.test-class').send_keys 'Body data'
    end

    click_button 'Create Post'
    expect(page).to have_content 'Post successfully created'
    click_link 'articles'
    expect(page).to have_content 'POST TITLE'
  end

  it 'Allows users to comment on a post' do
    click_link 'post_link'
    fill_in 'comment_field', with: 'First comment'
    click_button 'Comment'
    sleep(1)
    expect(page).to have_content 'Your comment was added'
  end
end
