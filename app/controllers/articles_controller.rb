class ArticlesController < ApplicationController
  def index 
    @articles = Article.includes(:user).order(created_at: :desc).limit(10)
    render json: @articles.as_json(include: {user: {only: :name}}, except: :user_id)
  end
end