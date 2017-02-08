class MessagesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user, only:[:create]

  def index
  end

  def show
  end

  def new
    @message = Message.new
    @user = current_user
    @users = User.all
    @@irb = Irb.find(Base64.decode64(params[:id]).to_i)
    if !Irb.find(@@irb).nil?
      @dat = @@irb 
      @messages = Message.where(irbappid: @@irb.id)
      @app = Message.where(irbappid: @@irb.id).pluck(:user_id).uniq
    end
  end

  def edit
  end

  def create
    params[:message][:user_id] = current_user.id
    if current_user.faculty? || current_user.committee?
      params[:message][:receiverid] = @@irb.user_id
    else
      params[:message][:receiverid] = params[:message][:data]   
    end
    params[:message][:irbappid] = @@irb.id
    @message = Message.new(message_params)
      if @message.save
        flash[:success] = "Message sent Successfully."
        redirect_to user_path(current_user)
      else
        render 'new'
      end
  end

 
  def update
  end

 
  def destroy
  end
  
  def correct_user
      #@@irb = Irb.find(@@irb)
      @user = User.find(@@irb.user_id)
    unless current_user?(@user) || current_user.admin?  || current_user.faculty? || current_user.committee?
      flash[:danger] = "You can't access others profile"
      redirect_to current_user
    end
  end

  private
  
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:msg, :user_id, :irbappid, :receiverid)
    end
end
