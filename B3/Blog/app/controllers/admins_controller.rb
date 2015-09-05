class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy,:edit_profile,:edit_password]
  # before_filter :authorize #限制访问，未登录则重定向到login
  protect_from_forgery
  before_filter :authorize,only: [:show, :edit, :update, :destroy,:edit_profile,:edit_password]
  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.all
  end

  def welcome
  end
  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end
  def edit_profile
  end
  #修改密码功能暂时没有，需要一个验证原密码的逻辑，懒
  def edit_password
  end
  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)
    @admin.description = "这个人真的很懒，什么都没留下..."
    @admin.avatar = ''
    respond_to do |format|
      if @admin.save
        format.html { redirect_to login_url, notice: "用户#{@admin.username}已创建成功！" }
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_url, notice: "用户#{@admin.username} 已修改成功！" }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit_profile }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to login_url, notice: "用户#{@admin.username} 已被删除" }
      format.json { head :no_content }
    end
  end

  # protected
  # def authorize
  #   unless Admin.find_by_id(session[:admin_id])
  #     redirect_to login_url , :notice => '请登录'
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      if params[:id].to_i == session[:admin_id]    #增加限制，不允许直接通过url访问其他用户
        @admin = Admin.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:username, :nickname, :hashed_password, 
        :salt, :password, :password_confirmation, :description)
    end
end
