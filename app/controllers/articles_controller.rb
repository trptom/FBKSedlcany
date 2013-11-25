class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])

    @comment = Comment.new
    @comment.article = @article
  end

  def new
    @article = Article.new

    #nastaveni textaci
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
            :result => false,
            :errors => @article.errors
          }
        end
      }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @res = @comment.destroy

    respond_to do |format|
      format.html {
        redirect_to :back
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end

  def newest
    @articles = Article.newest
  end

  def best
    # TODO - otestovat
    @articles = Article.top_marked
  end

  def most_commented
    # TODO - otestovat
    @articles = Article.most_commented
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
  
  def search
    if (params[:search])
      @articles = Article.published_at(params[:start] != "" ? params[:start] : nil, params[:end] != "" ? params[:end] : nil)
      
      if (params[:contains] != "")
        @articles = @articles.contains(params[:contains])
        #@articles = @articles.where("(lower(content) = lower(?)) OR (lower(title) = lower(?))", params[:contains], params[:contains])
      end
      
      @articles = @articles.all
    end
  end
end
