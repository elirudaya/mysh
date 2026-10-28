class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected] }

  validate :image_format

  private

  def image_format
    return unless image.attached?

    unless image.blob.content_type.in?(%w[image/jpeg image/png image/webp])
      errors.add(:image, "должна быть в формате JPG, PNG или WebP")
    end
  end
end
