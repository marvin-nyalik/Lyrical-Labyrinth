require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    post = FactoryBot.build(:post)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = FactoryBot.build(:post, title: nil)
    expect(post).to_not be_valid
  end

  it 'is invalid without a photo url' do
    post = FactoryBot.build(:post, photo_url: nil)
    expect(post).to_not be_valid
  end

  it 'is invalid without a body' do
    post = FactoryBot.build(:post, body: nil)
    expect(post).to_not be_valid
  end
end
