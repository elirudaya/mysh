class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_one :profile, dependent: :destroy
  after_create :create_user_profile

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy

  private

  def create_user_profile
    create_profile!
  end
end
