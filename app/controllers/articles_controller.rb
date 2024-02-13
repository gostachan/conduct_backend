class ArticlesController < ApplicationController
  def index 
    @articles = Article.includes(:user).order(created_at: :desc).limit(10)
    render json: @articles.as_json(include: {user: {only: :name}}, except: :user_id)
  end

  def create 
    current_user_id = 1
    @user = User.find(current_user_id)
    @article = @user.articles.create(article_params)
    render json: @article
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
  end


  private 

  def article_params 
    params.require(:article).permit(:title, :description, :content)
  end
end