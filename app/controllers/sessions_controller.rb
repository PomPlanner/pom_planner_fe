class SessionsController < ApplicationController

  def create
    # redirect_to 'http://localhost:5000/api/v1/auth/google_oauth2?prompt=select_account'
    redirect_to 'https://pom-planner-be-31825074f3c8.herokuapp.com/api/v1/auth/google_oauth2?prompt=select_account'
  end

  def omniauth
    user_id = params[:user_id]
    if user_id
      session[:user_id] = user_id
      Rails.logger.info("Session user_id set to: #{session[:user_id]}")
      Rails.logger.info("Session data: #{session.inspect}")
      redirect_to user_path(user_id), notice: "Signed in successfully"
    else
      redirect_to root_path, alert: "Authentication failed. Please try again."
    end
  end

  def destroy
    response = pom_planner_service.delete_url('https://pom-planner-be-31825074f3c8.herokuapp.com/api/v1/logout')
    if response[:status] == 200
      session[:user_id] = nil
      reset_session
      redirect_to root_path, notice: "Logged out!"
    else
      flash[:error] = "Failed to logout. Please try again."
      redirect_to root_path
    end
  end

  private

  def pom_planner_service
    @pom_planner_service ||= PomPlannerService.new
  end
end