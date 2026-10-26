class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: {
    in: %w[pending approved rejected]
  }

  scope :approved, -> { where(status: "approved") }
  scope :pending, -> { where(status: "pending") }
end
