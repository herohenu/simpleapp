class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "登录成功!"
      sign_in user
      redirect_to user
    else
      # Create an error message and re-render the signin form.
      flash[:error] = "用户名或密码错误!"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
