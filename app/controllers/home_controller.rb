class HomeController < ApplicationController
  def index
    @top_articles = Article.newest(TOP_ARTICLES_LIMIT)
    @other_articles = Article.newest(TOP_ARTICLES_LIMIT + OTHER_ARTICLES_LIMIT)
  end

  def error
  end
end
