class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    @user = User.where(username: params[:username]).first
    if @user
      session[:user_id] = @user.id
      redirect_to redirect_path @user
    else
      session[:user_id] = nil
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

private
  def redirect_path user
    puts user.student?
    if user.student?
      student_path user
    else
      root_url
    end
  end
end
