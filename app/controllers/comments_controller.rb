class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_post
	before_action :find_comment, only: [:destroy]

	def index
		@comments = @post.comments
	end

	def create
		@comment = @post.comments.create(comment_params)
		@comment.user = current_user

		respond_to do |format|
			if @comment.save
				format.html { redirect_to post_path(@post), notice: "Comment was successfully created." }
				format.json { render :show, status: :created, location: @post }
			else
				format.html { render :new }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_path(@post), notice: "Comment was successfully deleted." }
			format.json { head :no_content }
		end
	end

private
	# A comment cannot exsist without a post, therefore 
	# we find the post first
	def find_post
		@post = Post.find(params[:post_id])
	end

	def find_comment
		@comment = @post.comments.find(params[:id])
	end

	# White listing params
	def comment_params
		params.require(:comment).permit(:body)
	end
end
