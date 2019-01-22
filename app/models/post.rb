class Post < ApplicationRecord
  # Setup an association with the User model.
  belongs_to :user

  # Setup an association with the Like model.
  has_many   :likes, dependent: :destroy
  
  # Validations
  validates  :body, presence: true, length: { minimum: 1, maximum: 240 }, :allow_blank => false

  # Makes sure that every post created has an author/user
  validates  :user, presence: true
end
