FactoryBot.define do
  factory :tag do
    name { 'tag one' }
    desc { 'tag one desc' }

    after(:create) { |tag| tag.posts << create(:post) }
  end
end
