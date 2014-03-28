class HomeController < ApplicationController
  def index
    @jobs = Job.order("created_at desc").limit(4)
    @jobs_count = Job.count("id", :distinct => true)
    @job = Job.first
    @users = Role.find_by_name("mentor").users
    @notices = Notice.order("created_at desc").limit(4)
    @banners = Banner.all
  end
  
  def join_mentee
    job = Job.find params[:job_id]
    job.join_mentee(current_user)
  end
  
  def guide
  end
end
