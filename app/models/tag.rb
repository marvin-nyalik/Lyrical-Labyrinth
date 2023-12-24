class Tag < ApplicationRecord
  has_and_belongs_to_many :posts
  validates :name, presence: true
  validates :desc, presence: true
end