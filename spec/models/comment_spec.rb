require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'has a valid factory' do
    comment = FactoryBot.build(:comment)
    expect(comment).to be_valid
  end

  it 'is invalid without a body' do
    comment = FactoryBot.build(:comment, body: nil)
    expect(comment).to_not be_valid
  end
end
