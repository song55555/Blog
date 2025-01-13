class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id 
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to root_path 
    else
      flash[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def show 
    @post = Post.find_by(id: params[:id])
  end

  def index
    @posts = Post.limit(10).order(created_at: :desc)
  end

  def edit
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      flash[:alert] = "投稿が見つかりません"
      redirect_to root_path
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.nil?
      flash[:alert] = "投稿が見つかりません"
      redirect_to root_path and return
    end

    if @post.user == current_user && @post.update(post_params)
      flash[:notice] = "投稿が更新されました"
      redirect_to @post
    else
      flash[:alert] = "投稿の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = '投稿が削除されました'
    end
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end