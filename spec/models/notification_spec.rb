require 'rails_helper'

RSpec.describe Notification, type: :model do
  it 'Contains a valid factory' do
    user = FactoryBot.create(:user)
    comment = FactoryBot.create(:comment, user: user)

    notification = FactoryBot.build(:notification, user: user, notifiable_id: comment.id, notifiable_type: 'Comment')

    expect(notification).to be_valid
  end
end
