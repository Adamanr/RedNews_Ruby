class Edition < ApplicationRecord
  belongs_to :user
  has_one_attached :logo

  has_many :edition_subscriptions
  has_many :users, through: :edition_subscriptions

  validates :logo, presence: true
  validates :name, presence: true, length: { in: 5...20 }
  validates :desc, presence: true, length: { in: 10..50 }
  validates :url, presence: true
end
