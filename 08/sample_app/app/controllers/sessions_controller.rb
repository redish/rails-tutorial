class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # セッション登録.
      log_in user
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      redirect_to user_url(user)
      
    else
      # エラーメッセージを作成する
      #flash[:danger] = 'Invalid email/password combination' # 本当は正しくない
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
