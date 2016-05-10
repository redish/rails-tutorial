class UsersController < ApplicationController
  
  # filter.
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    #@users = User.all
    
    # ページネーション対応.
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    # 以下を入れると、コンソールデバッグできる.
    # Ctrl-Dで抜けれる.
    #debugger
  end
  
  def new
    @user = User.new
  end
  
  def create
    #@user = User.new(params[:user])    # 実装は終わっていないことに注意!
    @user = User.new(user_params)
    # Handle a successful save.
    if @user.save
      # 最初の１回だけ、表示する.
      flash[:success] = "Welcome to the Sample App!"
      # ログイン成功に設定.
      log_in @user
      # users/{id}にリダイレクト.
      redirect_to user_url(@user)
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
      # 最初の１回だけ、表示する.
      flash[:success] = "Profile updated"
      # users/{id}にリダイレクト.
      redirect_to user_url(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private

    # ユーザ登録用のパラメータチェック.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
