class Post < ApplicationRecord
  # Setup an association with the User model.
  belongs_to :user

  validates :body, presence: true, length: { minimum: 1, maximum: 240 }, :allow_blank => false
end
