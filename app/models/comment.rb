class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Order comments by the most recent first
  default_scope -> { order(created_at: :desc) }

  # Validates that body is not nil, empty, and maxium chars used are 500.
  validates :body, presence: true, allow_blank: false, length: { maximum: 500 }
end
