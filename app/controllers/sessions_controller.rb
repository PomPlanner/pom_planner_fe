class SessionsController < ApplicationController

  # def destroy
  #   session[:user_id] = nil
  #   redirect_to root_path, notice: "Logged out!"
  # end
  def create
    redirect_to 'http://localhost:5000/api/v1/auth/google_oauth2'
  end

  def omniauth
    user_id = params[:user_id]
    if user_id
      session[:user_id] = user_id
      redirect_to user_path(user_id), notice: "Signed in successfully"
    else
      redirect_to root_path, alert: "Authentication failed. Please try again."
    end
  end

  def destroy
    if pom_planner_service.delete_url('http://localhost:5000/logout')
      session[:user_id] = nil
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
  # def create
  #   redirect_to 'http://localhost:5000/api/v1/auth/google_oauth2'
  # end

  # def destroy
  #   if pom_planner_service.delete_url('http://localhost:5000/logout')
  #     session[:user_id] = nil
  #     redirect_to root_path, notice: "Logged out!"
  #   else
  #     flash[:error] = "Failed to logout. Please try again."
  #     redirect_to root_path
  #   end
  # end

  # private

  # def pom_planner_service
  #   @pom_planner_service ||= PomPlannerService.new
  # end

# end