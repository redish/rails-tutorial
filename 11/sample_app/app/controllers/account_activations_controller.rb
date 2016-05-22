class AccountActivationsController < ApplicationController

  # アカウントを有効化するeditアクション
  def edit
    user = User.find_by(email: params[:email])
    
    # 初めてアクティベートする場合のみ、有効にして、ログインを行う.
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      #user.update_attribute(:activated,    true)
      #user.update_attribute(:activated_at, Time.zone.now)
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
