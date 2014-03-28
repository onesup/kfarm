class Mentor::DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_mentor
  layout 'mentor'
  
  def index
    
  end
end
