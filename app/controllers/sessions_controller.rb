class SessionsController < ApplicationController
# rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user
    else
      # render json: {errors: user.errors}, status: :unauthorized
      render json: {errors: ["Username or Password Incorrect"]}, status: :unauthorized
    end
  end

  def destroy
    if session[:user_id] 
      session.destroy
      head :no_content
    else
      render json: {errors: ["No user logged in"]}, status: :unauthorized
    end
  end

  # def record_invalid(invalid)
  #   render json: {errors: invalid.record.errors.full_messages}, status: :unauthorized
  # end

end
