require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has a valid factory' do
    category = FactoryBot.build(:category)
    expect(category).to be_valid
  end

  it 'is invalid without a name' do
    category = FactoryBot.build(:category, name: nil)
    expect(category).to_not be_valid
  end

  it 'is invalid without a description' do
    category = FactoryBot.build(:category, description: nil)
    expect(category).to_not be_valid
  end

  it 'is invalid without a name shorter than 3 characters' do
    category = FactoryBot.build(:category, name: 'ab')
    expect(category).to_not be_valid
    expect(category.errors[:name]).to include('is too short (minimum is 3 characters)')
  end

  it 'is valid with a name at least 3 characters long' do
    category = FactoryBot.build(:category, name: 'abcd')
    expect(category).to be_valid
  end
end
