class User < ApplicationRecord
  # Downcase email address
  before_save :downcase_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Make the model omniauthable
  devise :omniauthable, omniauth_providers: %i[facebook]
  # Setup association with Post model. If a user is deleted, all their posts will be deleted too.
  has_many :posts, dependent: :destroy
  # =//= with the Like model. =//=
  has_many :likes, dependent: :destroy
  # Setup an association with the Comment model.
  has_many   :comments, dependent: :destroy

  # Using this regular expression and not the Official RFC 5322
  # because the official one is enormous. However, I am aware of it.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 

  validates :first_name, presence: true, length: { maximum: 50 }, :allow_blank => false
  validates :last_name,  presence: true, length: { maximum: 50 }, :allow_blank => false
  validates :email, length: { minimum: 1, maximum: 240 }, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, presence: true, :case_sensitive => false
  validates_presence_of :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end


def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.first_name = auth.info.first_name   # assuming the user model has a name
    user.last_name  = auth.info.last_name
    #user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
end

def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

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
