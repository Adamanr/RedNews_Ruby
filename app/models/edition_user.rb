class EditionUser < ApplicationRecord
  belongs_to :edition
  belongs_to :user
end
