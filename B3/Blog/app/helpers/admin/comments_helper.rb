module Admin::CommentsHelper
  def belong_to_admin comment
    post = Post.find_by(id: comment.post_id)
    return false if post == nil
    if session[:admin_id] == post.admin_id
      return true
    else
      false
    end
  end
end
