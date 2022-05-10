class ApplicationController < ActionController::Base
  include Pundit

  # This method is from Rails, not Devise or Pundit
  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  private

  # Here we define the error message, and call it using flash (provided by rails)
  # :alert was chosen as we wanted a proper alert notification for this error - Bootstrap ref
  def forbidden
    flash[:alert] = 'You are not authorised to perform that action!'
    redirect_to root_path
  end
end
