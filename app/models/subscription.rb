class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: 'User'
  belongs_to :subscribed, class_name: 'User'

end
