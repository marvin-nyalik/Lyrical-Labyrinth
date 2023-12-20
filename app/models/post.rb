class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  belongs_to :category

  has_rich_text :body

  validates :title, presence: true
  validates :photo_url, presence: true
  validates :body, presence: true
end
