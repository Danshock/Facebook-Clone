class Post < ApplicationRecord
  # Setup an association with the User model.
  belongs_to :user
  # Setup an association with the Like model.
  has_many   :likes, dependent: :destroy
  # Setup an association with the Comment model.
  has_many   :comments, dependent: :destroy
  # Order posts by the most recent first
  default_scope -> { order(created_at: :desc) }
  
  # Validations
  validates  :body, presence: true, length: { maximum: 240 }, :allow_blank => false
  # Makes sure that every post created has an author/user
  validates  :user, presence: true
end
