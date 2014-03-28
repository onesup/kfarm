class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include TheRoleUserModel
  # has_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, 
  :validatable, :omniauthable, :omniauth_providers => [:facebook]# , :confirmable 
  
  has_many :works, class_name: "Job", foreign_key: "mentor_id"
  has_many :jobs, through: :applications, foreign_key: "mentee_id"
  has_many :applications, foreign_key: "mentee_id"
  has_many :reviews
  belongs_to :role
  
  mount_uploader :avatar, AvatarUploader
  mount_uploader :farm, FarmUploader
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_by_email(auth.info.email)
    unless user
      user = User.new(  name:auth.extra.raw_info.name,
                       provider:auth.provider,
                       uid:auth.uid,
                       email:auth.info.email,
                       password:Devise.friendly_token[0,20])
    end
    user.token = auth.credentials.token
    user.remote_avatar_url = user.get_fb_profile_image
    user.save!
    user
  end
  
  def self.fb_username_to_fb_id(username)
    username = username.gsub("https://www.facebook.com","").gsub("https://facebook.com","")
    username = username.gsub("http://www.facebook.com","").gsub("http://facebook.com","")
    oauth = Koala::Facebook::OAuth.new(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret])
    graph = Koala::Facebook::API.new(oauth.get_app_access_token)
    begin
      graph.get_object(username)["id"]
    rescue
      ""
    end
  end
  
  def get_fb_profile_image
    oauth = Koala::Facebook::OAuth.new(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret])
    graph = Koala::Facebook::API.new(self.token)
    begin
      graph.get_picture(self.uid,{type: "large"})
    rescue
      ""
    end
  end
  
  def current_works
    self.works
  end
  
  def work_categories
    categories = Array.new
    self.works.each do |work|
      categories << work.category
    end
    categories * " "
  end
  
  def work_startday
    days = Array.new
    self.works.each do |work|
      days << work.started_at.strftime("%Y.%m.%d")
    end
    days * " "
  end
  
  
  
end
