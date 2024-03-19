FactoryBot.define do
  factory :notification do
    action { 'Default action' }

    association :user
    association :notifiable, factory: :comment

    after(:build) do |notification|
      notification.notifiable_id = notification.notifiable.id
      notification.notifiable_type = notification.notifiable.class.to_s
    end
  end
end
