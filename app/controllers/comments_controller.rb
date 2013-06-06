include CommentsHelper 

class CommentsController < ApplicationController

  def react
    @reacted_comment = get_comment_by_params_id
    @comment = Comment.new
    @comment.article = nil
    @comment.comment = @reacted_comment
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    @res = @comment.save

    respond_to do |format|
      format.html {
        @root_comment = @comment
        while !@root_comment.article && @root_comment.comment do
          @root_comment = @root_comment.comment
        end

        if @root_comment.article
          redirect_to @root_comment.article
        else
          redirect_to "/"
        end
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
        @root_comment = @comment
        while !@root_comment.article && @root_comment.comment do
          @root_comment = @root_comment.comment
        end

        if @root_comment.article
          redirect_to @root_comment.article
        else
          redirect_to "/"
        end
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

    @root_comment = @comment
    while !@root_comment.article && @root_comment.comment do
      @root_comment = @root_comment.comment
    end

    if @root_comment.article
      @redirect = @root_comment.article
    else
      @redirect = "/"
    end

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
