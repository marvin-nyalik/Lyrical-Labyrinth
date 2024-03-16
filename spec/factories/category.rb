FactoryBot.define do
  factory :category do
    name { 'Poetry' }
    description { 'Poetic brizzle' }

    after(:create) { |category| category.posts << create(:post) }
  end
end