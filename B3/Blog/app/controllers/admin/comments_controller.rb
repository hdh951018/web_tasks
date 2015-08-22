class Admin::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end
  def checked
    @comments = Comment.all
  end
  def unchecked
    @comments = Comment.all 
  end
  def check_switch 
    if params[:check] 
      params[:check].each do |id|
        comment = Comment.find_by(id: id)
        comment.is_checked = (comment.is_checked ? false : true)
        comment.save
      end
    end
    redirect_to admin_comments_uncheck_url  
  end
  # GET /comments/1
  # GET /comments/1.json
  def show
  end


  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to admin_comments_url, notice: '评论已被成功删除' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:post_id, :email, :name, :content, :is_checked)
    end
end

