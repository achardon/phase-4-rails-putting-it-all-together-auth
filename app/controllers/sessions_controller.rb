class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user
    else
      # render json: {error: user.errors.full_messages}, status: :unauthorized
      render json: {error: "Username or Password Incorrect"}, status: :unauthorized
    end
  end

  def destroy
    if session[:user_id] 
      session.destroy
      head :no_content
    else
      render json: {error: "No user logged in"}, status: :unauthorized
    end
  end
end
