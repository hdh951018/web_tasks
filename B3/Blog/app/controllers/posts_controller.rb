class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    #全部文章
    @posts = Post.all
    #通过类别
    if params[:category_active]
      @posts = Post.where(category: params[:category_active])
    end
    #通过月份
    if params[:month_active]
      @posts = Array.new
      postss = Post.all
      postss.each do |t|
        #循环查询创建时间是否有包含指定月份的，效率较低but useful for now
        @posts.push(t) if t.created_at.to_s.include?(params[:month_active])
      end
      @posts
    end
      
    unless session[:admin_id]
      render "index_visitor",layout: false
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.all
    unless session[:admin_id]
      render "show_visitor"
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    #自动填写以下内容，包括admin_id,summary
    @post.admin_id = session[:admin_id].to_i
    @post.summary = summary(@post.content)
    respond_to do |format|
      if @post.save
        format.html { redirect_to "/admin/posts/#{@post.id}", notice: '发表成功' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new  }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to "/admin/posts/#{@post.id}", notice: '更新成功' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { redirect_to "/admin/posts/#{@post.id}/edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url, notice: 'Post was successfully destroyed.' }
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
end
