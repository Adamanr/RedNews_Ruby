class User < ApplicationRecord
  has_one_attached :avatar

  belongs_to :user_role
  has_many :bookmarks
  has_many :likes

  has_many :articles_comments
  has_many :updates_comments

  has_many :subscriber_subscriptions, class_name: 'Subscription', foreign_key: 'subscriber_id', dependent: :destroy
  has_many :subscribed_subscriptions, class_name: 'Subscription', foreign_key: 'subscribed_id', dependent: :destroy

  has_many :edition_subscriptions
  has_many :editions, through: :edition_subscriptions

  has_many :subscribers, through: :subscribed_subscriptions, source: :subscriber
  has_many :subscribed_users, through: :subscriber_subscriptions, source: :subscribed

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
