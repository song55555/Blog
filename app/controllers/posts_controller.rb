class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :set_post, only: [:update, :destroy]
    before_action :authorize_user, only: [:update, :destroy]
  
      def create
          @post = Post.new(post_params)
          @post.user = current_user
          if @post.save
              render json: { post: @post, message: '投稿しました', success: true }, status: :created
          else
              render json: { errors: @post.errors.full_messages, success: false }, status: :unprocessable_entity
          end
      end
  
      def show
          @post = Post.find_by(id: params[:id])
          if @post.nil?
              render json: { error: '投稿が見つかりません' }, status: :not_found and return
          end
          render json: @post.as_json(include: [:user, :tags, :category])
      end
  
      def index
          @posts = Post.order(created_at: :desc)
  
          if params[:category_id].present?
              @posts = @posts.where(category_id: params[:category_id])
          end
  
          if params[:q].present? || params[:term].present?
              search_term = params[:q] || params[:term]
              @posts = @posts.where("title LIKE ? OR content LIKE ?", "%#{search_term}%", "%#{search_term}%")
          end
  
  
          page = params[:page].to_i.positive? ? params[:page].to_i : 1
          per_page = params[:per_page].to_i.positive? ? params[:per_page].to_i : 5
          @posts = @posts.page(page).per(per_page)
          total_count = @posts.total_count
  
          render json: { posts: @posts.as_json(include: [:user, :tags, :category]), total_count: total_count }
      end
  
      def update
           if @post.update(post_params)
              render json: @post, status: :ok
           else
              render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
           end
      end
  
      def destroy
          @post.destroy
          head :no_content
      end
  
      private
  
      def set_post
          @post = Post.find_by(id: params[:id])
          if @post.nil?
              render json: { error: '投稿が見つかりません' }, status: :not_found and return
           end
      end
  
      def post_params
          params.require(:post).permit(:title, :content, :category_id, tag_names: [])
      end
  
      def authorize_user
          unless @post.user == current_user
             render json: { error: '権限がありません.' }, status: :unauthorized
          end
      end
  end