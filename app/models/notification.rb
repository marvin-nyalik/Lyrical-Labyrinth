class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :action, presence: true
  validates :notifiable_id, :notifiable_type, presence: true
end
