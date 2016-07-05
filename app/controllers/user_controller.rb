class UserController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def new
  	@user=User.new
  end
  def show
  	 @user = User.find(params[:id])
  end
  def create
  	@user=User.new(user_params)
  	if @user.save
      flash[:success]="Welcome to the app"
            redirect_to @user
  	else
  		render 'new'
  	end
  end
  def edit
      @user = User.find(params[:id])
    end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user

    else
      render 'edit'
    end
  end
  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  def index
    @user = User.paginate(page: params[:page])
  end
  private
  	def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
    
end
