class UsersController < ApplicationController
  #before_action :set_user, only: %i[ show edit update destroy ]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users or /users.json
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @microposts = Micropost.where(user_id: @user.id)
    #redirect_to root_url and return unless FILL_IN
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    #respond_to do |format|
      if @user.save
        ExampleMailer.sample_email(@user).deliver
        #@user.send_activation_email
        #msg = "http://localhost:3000/account_activations/" + @user.activation_token + "/edit?email=" + @user.email.gsub("@","%40")
        #msg2 = "https://tranquil-waters-82690.herokuapp.com/account_activations/" + @user.activation_token + "/edit?email=" + @user.email.gsub("@","%40")
        flash[:info] = "Please check your email to activate your account.\n"
        redirect_to root_url
      else
        render 'new'
      end
    #end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        #store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
