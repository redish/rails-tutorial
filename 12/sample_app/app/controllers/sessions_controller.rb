class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # セッション登録.
      #log_in user
      
      # 永続化.
      #params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      #redirect_to user_url(user)
      
      # ログイン前に覚えたURLに遷移.
      #redirect_back_or user
      
      # アクティベートユーザの場合は、ログイン後に、対象ページに移動.
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      
      # アクティベートユーザで無い場合は、ログインできない.
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
      
    else
      # エラーメッセージを作成する
      #flash[:danger] = 'Invalid email/password combination' # 本当は正しくない
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
