class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_user_management, only: [:index, :edit, :update, :destroy]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
    def index
      if params[:email]
       
        @users = User.where("users.email like ?", "%#{params[:email]}%")
        else
          @users = User.all 
      end
      @users 
    end

    def show
    end
  
    def edit
    end
  
    def update
      if @user.update(user_params)
        redirect_to users_path, notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user.destroy!
      redirect_to users_path, notice: "User was successfully destroyed."
    end

    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:email, :role)
    end
  
    def authorize_user_management
      unless current_user.admin? || current_user.moderator?
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
  end
  