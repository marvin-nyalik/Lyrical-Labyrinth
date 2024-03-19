RSpec.describe Notification, type: :model do
  it 'Contains a valid factory' do
    comment = FactoryBot.build(:comment)
    notification = FactoryBot.build(:notification, notifiable: comment)
    expect(notification).to be_valid
  end
end
