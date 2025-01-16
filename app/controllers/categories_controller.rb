class CategoriesController < ApplicationController
    def index
      @categories = Category.all
      render json: @categories
      rescue => e
        render json: { error: e.message }, status: 500
    end
  end