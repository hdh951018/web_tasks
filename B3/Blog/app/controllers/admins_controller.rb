class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  # before_filter :authorize #限制访问，未登录则重定向到login
  protect_from_forgery
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

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admins_url, notice: "用户#{@admin.username}已创建成功！" }
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
        format.html { redirect_to admins_url, notice: "用户#{@admin.username} 已修改成功！" }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: "用户#{@admin.username} 已被删除" }
      format.json { head :no_content }
    end
  end

  protected
  def authorize
    unless Admin.find_by_id(session[:admin_id])
      redirect_to login_url , :notice => '请登录'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:username, :nickname, :hashed_password, :salt, :password, :password_confirmation)
    end
end
