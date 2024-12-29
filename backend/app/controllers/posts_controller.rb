class PostsController < ApplicationController
  # 認証の実装後に削除
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: { message: 'Post deleted successfully' }, status: :ok
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :image_url, :description, :user_id)
  end
end