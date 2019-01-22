class User < ApplicationRecord
  # Downcase email address
  before_save :downcase_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Setup association with Post model. If a user is deleted, all their posts will be deleted too.
  has_many :posts, dependent: :destroy
  # =//= with the Like model. =//=
  has_many :likes, dependent: :destroy

  # Using this regular expression and not the Official RFC 5322
  # because the official one is enormous. However, I am aware of it.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 

  validates :first_name, presence: true, length: { minimum: 1, maximum: 50 }, :allow_blank => false
  validates :last_name,  presence: true, length: { minimum: 1, maximum: 50 }, :allow_blank => false
  validates :email, length: { minimum: 1, maximum: 240 }, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, presence: true, :case_sensitive => false
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?

protected

  #def email_required?
  #  true && profile_updation.blank?
  #end

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end

private

  def downcase_email
    self.email = email.downcase
  end
  
end
