class SignInController < ApplicationController
  def create
    if params[:sign_in][:password] == 'secret' && params[:sign_in][:hp].empty?
      session[:signed_in] = true
    else
      flash[:error] = 'Incorrect password, sir.'
    end
    redirect_to root_path
  end
end
