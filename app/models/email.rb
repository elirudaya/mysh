class Email < ApplicationRecord
  before_validation :clean_address

  validates :address, presence: true,
                      uniqueness: { case_sensitive: false },
                      format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :consent, acceptance: { accept: true }

  private

  def clean_address
    self.address = address.to_s.strip.downcase
  end
end
