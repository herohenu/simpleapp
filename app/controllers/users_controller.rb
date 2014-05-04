class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = "Welcome to the Sample App!"
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "资料更新成功!"
      #format.html { redirect_to @user, notice: 'User was successfully updated.' }
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def signed_in_user
    #redirect_to signin_url, notice: "Please sign in." unless signed_in?
    unless  signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  #user only can edit self profile
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path, notice: "request error." unless current_user?(@user)
  end

end

