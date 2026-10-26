class Profile < ApplicationRecord
  belongs_to :user

  validates :age,
            numericality: {
              only_integer: true,
              greater_than: 0,
              less_than_or_equal_to: 115
            },
            allow_blank: true
end
