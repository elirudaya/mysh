class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_interests, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  has_many :places, dependent: :destroy
  has_many :trips, dependent: :destroy
  has_many :checklists, dependent: :destroy
  has_many :events, dependent: :destroy
end
