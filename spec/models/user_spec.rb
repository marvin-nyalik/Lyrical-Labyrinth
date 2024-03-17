require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a full name' do
    user = FactoryBot.build(:user, full_name: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without an email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without an avatar' do
    user = FactoryBot.build(:user, avatar_url: nil)
    expect(user).to_not be_valid
  end
end