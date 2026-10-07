class Interest < ApplicationRecord
  has_many :user_interests, dependent: :destroy
end
