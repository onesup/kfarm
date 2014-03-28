#encoding: utf-8
class ApplicationController < ActionController::Base
  include TheRoleController
  protect_from_forgery with: :exception
  
  # your Access Denied processor
  def access_denied
    redirect_to root_path, notice: '권한이 필요합니다.'
  end

  # Define method aliases for the correct TheRole's controller work
  alias_method :login_required,     :authenticate_user!
  alias_method :role_access_denied, :access_denied
  
  def check_admin
    unless current_user.role.name == "admin"
      redirect_to root_path, notice: '권한이 필요합니다.'
    end
  end
  
  def check_mentor
    unless current_user.role.name == "mentor" or current_user.role.name == "admin"
      redirect_to root_path, notice: '권한이 필요합니다.'
    end
  end
  
end

class CustomFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == :user
      new_user_registration_path
    else
      new_user_registration_path
    end
  end
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
