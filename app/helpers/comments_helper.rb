# To change this template, choose Tools | Templates
# and open the template in the editor.

module CommentsHelper
  def get_comment_by_params_id
    if !params[:id]
      logger.info "id is not included in params"
      page_not_found
    end

    comment = Comment.find_by_id(params[:id]);
    if !comment
      logger.info "no record with id " + params[:id] + " found"
      page_not_found
    end

    return comment
  end
end
