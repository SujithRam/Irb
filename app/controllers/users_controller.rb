class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :destroy, :show, :edit]
  before_action :login_admin, only:[:index, :destroy]
  before_action :correct_user, only:[:show]
  
  def new
    if logged_in?
      if current_user.admin? || current_user.faculty? || current_user.committee?
        @user = User.new
      else
        redirect_to root_url
      end
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)    #user_params is defined below
    if @user.save
      #UserMailer.signup_confirmation(@user).deliver
      if logged_in?   #new user added by admin or Faculty, then no need to log in just add to db.
        flash[:success] = "User added to Database Successfully !!"
        redirect_to user_path(current_user)
      else
        log_in @user
        #current_user.update_attributes(:lastlogin, Time.now)
        flash[:success] = "Welcome to the Institutional Review Board Application!"
        redirect_to @user
      end
    else
      render 'new'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    @user = User.find(params[:id])
    @irbs = @user.irbs
    @messages = @user.messages
    @messages.destroy
    Message.destroy_all(:receiverid => @user.id)
    @irbs.destroy
    @user.destroy
    flash[:success] = "User details and Applications Deleted!"
    redirect_to users_path
  end

  def edit
  end

  def show
    @user=User.find(params[:id])
    if current_user.faculty?
      @irbs= Irb.where(faculty_status: 0)       
      #TODO, show application classification New applications submitted after last login and old unread applications
    elsif current_user.committee?
      @irbs= Irb.where(committee_status: 0)
    else
      current_user.touch(:lastlogin)
      if @user.irbs.count != 0
        @irb = @user.irbs.paginate(page: params[:page])
      end
    end
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
  end
  
  def correct_user
    @user=User.find(params[:id])
    unless current_user?(@user) || current_user.admin?      #current_user is a dmin then allow to access to view any user profile, if not check the validaity of the user
      flash[:danger] = "You can't access others profile"
      redirect_to current_user
    end
  end
  
  def login_admin
      unless current_user.admin?
      redirect_to root_url
      flash[:danger] = "Administrator is only allowed to access registrations index page." 
      end
  end
  
  private
  def user_params
    if logged_in?
      if current_user.admin?
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :ulid, :faculty, :committee, :admin)
      else
        if current_user.faculty?
          params.require(:user).permit(:name, :email, :password, :password_confirmation, :ulid, :faculty)
        elsif current_user.committee?
          params.require(:user).permit(:name, :email, :password, :password_confirmation, :ulid, :committee)
        end
      end
     else
       params.require(:user).permit(:name, :email, :password, :password_confirmation, :ulid)
    end
  end
end
