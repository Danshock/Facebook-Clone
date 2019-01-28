class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all
		@post  = Post.new
		@users = User.all
	end

	def show
		
	end

	# GET /posts/1/new
	def new
		@post = current_user.posts.build
	end

	# Get /posts/id/edit
	def edit
	end

	# POST /posts
	# POST /posts.json
	def create
		@post = current_user.posts.build(post_params)

		respond_to do |format|
			if @post.save
				format.html { redirect_to root_path, notice: "Post was successfully created." }
				format.json { render :show, status: :created, location: @post }
			else
				format.html { render :new }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /posts/1
	# PATCH/PUT /posts/1.json
	def update
		respond_to do |format|
			if @post.update(post_params)
				format.html { redirect_to root_path, notice: "The post was successfully updated!" }
				format.json { render :show, status: :ok, location: @post }
			else
				format.html { render :edit }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /posts/1
	# DELETE /posts/1.json
	def destroy
		@post.destroy
		respond_to do |format|
			format.html { redirect_to root_url, notice: "The post was successfully deleted!" }
			format.json { head :no_content }
		end
	end

private
	# Use callbacks to share common setup or constraints between actions.
	def set_post
		@post = Post.find(params[:id])
	end

	# White list parameters
	def post_params
		params.require(:post).permit(:body)
	end
end
