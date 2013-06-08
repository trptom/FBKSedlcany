class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])

    @comment = Comment.new
    @comment.article = @article
  end

  def new
    @article = Article.new

    #nastaveni textaci
    @form_submit = I18n.t("messages.articles.new.create");
  end

  def create
    @article = Article.new(params[:article])
    @article.user = current_user

    @res = @article.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @article
        else
          @errors = @article.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :article => @article
          }
        else
          render :json => {
            :state => false
          }
        end
      }
    end
  end

  def edit
    @article = @article.find(params[:id])

    #nastaveni textaci
    @form_submit = I18n.t("messages.articles.edit.update");
  end

  def update

  end

  def destroy

  end

  def newest
    @articles = Article.order(:updated_at).limit(ARTICLES_LIST_PAGE_LIMIT).all
  end

  def best
    # TODO
    @articles = []
  end

  def most_commented
    # TODO
    @articles = []
  end
end
