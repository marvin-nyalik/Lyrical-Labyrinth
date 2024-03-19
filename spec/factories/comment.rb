FactoryBot.define do
  factory :comment do
    body { 'A comment' }
    association :post, strategy: :build
    association :user, strategy: :build
    parent { nil }
  end
end
