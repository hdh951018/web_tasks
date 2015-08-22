class Admin::PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :destroy,:show_admin]
  before_filter :authorize

  def index
    @posts = Post.all
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.all
  end
  def show_admin
    @comments = Comment.all
    # @post = Post.find(params[:id])
    render 'show'
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.cover = '/uploads/post/cover/0/default.png'
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    #自动填写以下内容，包括admin_id,summary
    @post.admin_id = session[:admin_id].to_i
    @post.summary = "summary(@post.content)"
    respond_to do |format|
      if @post.save
        format.html { redirect_to "/admin/posts/#{@post.id}/show", notice: '文章发表成功' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to "/admin/posts/#{@post.id}/show", notice: '文章更新成功' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: '文章删除成功' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :cover, :admin_id, :category, :summary)
    end

    #通过判断是否登录选择对应的布局

end
