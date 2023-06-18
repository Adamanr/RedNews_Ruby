class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :header
  acts_as_taggable_on :tags
  is_impressionable counter_cache: true, column_name: :impressions_count
  belongs_to :user

  FORBIDDEN_WORDS = %w(гей сука)

  has_rich_text :content

  has_many :bookmarks, as: :bookmarkable

  has_many :likes, as: :likable

  has_many :event_comments
  has_many :users, through: :event_bookmarks

  validates :header, presence: true
  validates :title, presence: true, length: { in: 10..100 }, exclusion: { in: FORBIDDEN_WORDS,
    message: "Вы указали плохие слова в заголовке! Удалите их из текста" }
  validates :content, presence: true, length: { in: 150..20000 }
  validate :tag_limit

  private

  def tag_limit
    errors.add(:base, 'Превышено количество тэгов') if tag_list.count > 5

  end
end
