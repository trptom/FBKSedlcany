class ArticlesController < ApplicationController

  def show
    
  end

  def new
    @article = Article.new
  end

  def create

  end

  def edit
    @article = @article.find(params[:id])
  end

  def update

  end

  def destroy

  end
end
