class Event < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :title, :description, :date, :city, presence: true
end
