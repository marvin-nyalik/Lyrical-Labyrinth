FactoryBot.define do
  factory :notification do
    action { 'Default action' }

    association :user
    association :notifiable, factory: :comment
  end
end
