class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :header
  acts_as_taggable_on :tags
  is_impressionable counter_cache: true, column_name: :impressions_count
  belongs_to :user

  has_rich_text :content

  has_many :bookmarks, as: :bookmarkable

  has_many :likes, as: :likable

  has_many :event_comments
  has_many :users, through: :event_bookmarks

  validates :header, presence: true
  validates :title, presence: true, length: { in: 10..100 }
  validates :content, presence: true, length: { in: 150..20000 }
end
