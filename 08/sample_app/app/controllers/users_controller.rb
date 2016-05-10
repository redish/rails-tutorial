class UsersController < ApplicationController
  
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
  
  private

    # ユーザ登録用のパラメータチェック.
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
end
