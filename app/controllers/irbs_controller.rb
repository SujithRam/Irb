class IrbsController < ApplicationController
  before_action :correct_user, only:[:destroy, :show, :edit]
  before_action :logged_in_user, only: [:index, :destroy, :show, :edit, :new]
  before_action :login_correct_user, only:[:index]
  before_action :login_admin, only:[:destroy]
  
  def new
    if current_user.admin? || current_user.faculty? ||current_user.committee? #can also be written using before_action also
      redirect_to current_user
    else
      @irb = Irb.new
      @irb.student_name = current_user.name
    end
  end
  
  def create
    params[:irb][:student_name] = current_user.name
    params[:irb][:proposalno] = 'Not Yet Assigned'
    params[:irb][:status] = params[:status]
    params[:irb][:responsibility] = params[:responsibility]
    params[:irb][:poputype] = params[:poputype]
    params[:irb][:acc1] = 'Accepted'
    params[:irb][:date1] = Time.now.strftime("%m/%d/%Y")
      @irb = current_user.irbs.build(irb_params)        #with has_many relationship
      if @irb.save
        flash[:success] = "Application has been saved."
        redirect_to user_path(current_user)
      else
        render 'new'
      end
  end

  def index
    @user = current_user
    @irbs = Irb.paginate(page: params[:page])
  end

  def edit
    @user = current_user
    if current_user.faculty? || current_user.committee?
      @irb = Irb.find_by(id: params[:id])
    else
      @irb = current_user.irbs.find_by(id: params[:id])
      if @irb.committee_status == 2
        redirect_to current_user
      end
    end
  end
  
  def update
    if current_user.faculty? || current_user.committee?
      @irb = Irb.find_by(id: params[:id])
    else
      @irb = current_user.irbs.find_by(id: params[:id])        #with has_many relationship
    end
    params[:irb][:status] = params[:status]         #copying data from tag fields to form fields
    params[:irb][:responsibility] = params[:responsibility]
    params[:irb][:poputype] = params[:poputype]
    params[:irb][:acc1] = 'Approved'      #So the user once approves his application during creation can't remove the approval
    if current_user.faculty?
      params[:irb][:acc2] = params[:acc2]
    end
    if current_user.committee?
      params[:irb][:acc3] = params[:acc3]
    end
    if params[:irb][:acc2].eql?("Certified") && @irb.acc2.nil?
      params[:irb][:faculty_name] = current_user.name
      params[:irb][:faculty_status] = 1       #Chair(moderator) certified the request
      params[:irb][:committee_status] = 0     #Committee can access the form and is unread
    end
    if params[:irb][:acc3].eql?("Approved") && @irb.acc3 != "Approved"
      params[:irb][:committee_name] = current_user.name
      params[:irb][:committee_status] = 1   #Committee reviewed the form and approved
    end
    if @irb.update_attributes(irb_params)
      flash[:success] = "Application details are Updated."
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end
  
  def destroy
     Irb.find(params[:id]).destroy
     redirect_to irbs_path
  end

  def show
    if current_user.faculty? || current_user.committee?
      @irb = Irb.find_by(id: params[:id])
    else
      @irb = current_user.irbs.find_by(id: params[:id])
    end
  end
  
  def correct_user
    @user=current_user
    unless current_user?(@user) || current_user.faculty?  || current_user.committee? || current_user.admin?
      flash[:danger] = "You can't access others profile"
      redirect_to current_user
    end
  end
  
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
  end
  
  def login_correct_user
      unless current_user.admin? || current_user.faculty? || current_user.committee?
      redirect_to root_url
      flash[:danger] = "Administrator is only allowed to access Application index page, Please Log in." 
      end
  end
  
  def login_admin
    unless current_user.admin?
      redirect_to user_path(current_user)
      flash[:danger] = "Only Administrator can delete the Application"
    end
  end
  private
  def irb_params
      params.require(:irb).permit!
  end
end
