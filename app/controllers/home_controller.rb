class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  	@posts = Post.all.order('id DESC')
  	@users = User.all
  	redirect_to new_user_registration_path if !user_signed_in?
  end

end
