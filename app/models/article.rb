class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :header
  acts_as_taggable_on :tags
  is_impressionable counter_cache: true, column_name: :impressions_count


  has_many :article_bookmarks
  has_many :users, through: :article_bookmarks
  has_many :bookmarks, as: :bookmarkable

  has_many :likes, as: :likable

  has_many :articles_comments
  has_rich_text :content

  validates :header, presence: true
  validates :title, presence: true, length: { in: 10..70 }
  validates :content, presence: true, length: { in: 150..20000 }
  validate :tag_limit

  private

  def tag_limit
    errors.add(:base, 'Превышено количество тэгов') if tag_list.count > 5
  end
end
