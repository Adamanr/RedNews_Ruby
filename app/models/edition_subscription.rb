class EditionSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :edition
end
