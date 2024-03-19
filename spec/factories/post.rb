FactoryBot.define do
  factory :post do
    title { 'First Post' }
    photo_url { 'https://photo.com/1' }
    body { 'The body' }

    association :category, strategy: :build
    association :user
    after(:create) { |post| post.tags << create(:tag) }
    after(:create) { |post| post.comments << create(:comment) }
  end
end
