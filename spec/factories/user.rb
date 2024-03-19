FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    full_name { 'John Doe' }
    avatar_url { 'https://facebook.com/user/avatar.jpg' }
    password { 'password' }

    # after(:create) { |user| user.posts << create(:post) }
    # after(:create) { |user| user.comments << create(:comment) }

    # after(:create) do
    #   comment = create(:comment)
    #   user.notifications << create(:notification, notifiable: comment)
    # end
  end
end
