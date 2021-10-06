class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
    def post_params
      params.require(:post).permit(:user_id, :category_id, :title, :body, :post_image_id)
    end
  
    

end

