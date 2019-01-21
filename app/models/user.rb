class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Setup association with Post model. If a user is deleted, all their posts will be deleted too.
  has_many :posts, dependent: :destroy

  validates :first_name, presence: true, length: { minimum: 1, maximum: 240 }, :allow_blank => false
  validates :last_name,  presence: true, length: { minimum: 1, maximum: 240 }, :allow_blank => false
  validates :email,      presence: true, length: { minimum: 1, maximum: 240 }, :allow_blank => false, uniqueness: true
end
