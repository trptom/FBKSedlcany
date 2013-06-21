include CommentsHelper 

class CommentsController < ApplicationController

  def react
    @reacted_comment = get_comment_by_params_id
    @comment = Comment.new
    @comment.article = @reacted_comment.article
    @comment.comment = @reacted_comment
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    @res = @comment.save

    respond_to do |format|
      format.html {
        redirect_to article_path(@comment.article_id)
      }
      format.json {
        render json: {
          :result => @res,
          :comment => @comment
        }
      }
    end
  end

  def edit
    @comment = get_comment_by_params_id
  end

  def update
    @comment = get_comment_by_params_id
    @comment.update_attributes(params[:comment])
    @res = @comment.save

    respond_to do |format|
      format.html {
        redirect_to @comment.article
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :comment => @comment
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
    @comment = get_comment_by_params_id
    @redirect = @comment.article

    @res = @comment.destroy

    respond_to do |format|
      format.html {
        redirect_to @redirect
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end
end
