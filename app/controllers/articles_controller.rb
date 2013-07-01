class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])

    @comment = Comment.new
    @comment.article = @article
  end

  def new
    @article = Article.new

    #nastaveni textaci
    @form_title = I18n.t("messages.articles.new.title")
    @form_submit = I18n.t("messages.articles.new.create")
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
    @article = Article.find(params[:id])

    #nastaveni textaci
    @form_title = I18n.t("messages.articles.edit.title")
    @form_submit = I18n.t("messages.articles.edit.update")
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])
    @res = @article.save

    respond_to do |format|
      format.html {
        redirect_to @article
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :article => @article
          }
        else
          render json: {
            :result => false
          }
        end
      }
    end
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
    @articles = Article.most_commented(1)
  end

  # nastaveni, uprava nebo smazani
  def set_mark
    @article = @article.find(params[:id])
    @mark = Mark.where(:user_id => current_user.id, :article_id => params[:id]).first

    if (!params[:value] || !(params[:value].to_i) ||
          params[:value].to_i < MARK_MIN || params[:value].to_i > MARK_MAX)
      if (@mark)
        @res = @mark.destroy
      else
        @res = true
      end
    else
      if (@mark)
        @mark = Mark.new(
          :user_id => current_user.id,
          :article_id => @article.id,
          :value => params[:value]
        )
      else

      end
    end
  end
end
