class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_admin
  layout 'admin'
  
  def index
    
  end
end
