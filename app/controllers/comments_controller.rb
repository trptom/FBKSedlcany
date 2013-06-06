class CommentsController < ApplicationController

  # musi mit (jinak hazi error):
  #   params[:comment]
  #   params[:comment][:article_id]
  # mel by mit (jinak se comment neprida):
  #   params[:comment][:title]
  #   params[:comment][:content]
  def create
    if !params[:comment] || !params[:comment][:article_id] || !current_user
      wrong_params
    end

    @res = false
    if params[:comment][:title] && params[:comment][:content]
      @comment = Comment.new(params[:comment])
      @comment.user = current_user
      @res = @comment.save
    end

    respond_to do |format|
      format.html {
        redirect_to article_path(params[:comment][:article_id])
      }
      format.json {
        render json: {
          :result => @res,
          :comment => @comment
        }
      }
    end
  end

  def destroy
    if !params[:id]
      page_not_found
    end

    @comment = Comment.find_by_id(params[:id]);
    if !@comment
      page_not_found
    end

    @article = @comment.article

    @res = @comment.destroy

    respond_to do |format|
      format.html {
        redirect_to @article
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end
end
