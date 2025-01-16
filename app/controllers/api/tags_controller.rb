class Api::TagsController < ApplicationController
    def index
      @tags = Tag.all
      render json: @tags
    end
    def show
      @tag = Tag.find(params[:id])
      render json: @tag
    end
    def posts
        @tag = Tag.find(params[:id])
        @posts = Post.joins(:tags).where(tags: {id: @tag.id}).order(created_at: :desc)
        render json: { posts: @posts.as_json(include: [:user, :tags, :category]), total_count: @posts.size }
    end
end