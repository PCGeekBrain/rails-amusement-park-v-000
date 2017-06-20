class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def signin
    @user = User.new
  end

  def show
    if !logged_in?
      redirect_to '/'
    end
    @user = User.find_by(id: params[:id])
  end

  # Handle sign in and up
  def create
    @user = User.find_by(name: post_params[:name])
    if @user # Log them in if they exist
      if @user.authenticate(post_params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render :new
      end
    else
      @user = User.create(post_params)
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find_by(name: post_params[:name])
    @user.update(post_params)
    redirect_to user_path(@user)
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private
  def post_params
    params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
  end
end
