require 'rails_helper'

RSpec.describe Post, type: :model do
  it "Validates presence of title, body and photo URL" do
    post = Post.new(title: nil, body: nil, photo_url: nil)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end
end