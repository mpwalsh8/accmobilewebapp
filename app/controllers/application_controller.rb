class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  ##  Commented out 8/8 to stop CSRF errors - MPW
  #protect_from_forgery with: :exception
end
