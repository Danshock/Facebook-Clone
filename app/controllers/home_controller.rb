class HomeController < ApplicationController
  def index
  	@posts = Post.all.order('id DESC')
  	@users = User.all
  end

end
