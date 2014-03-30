require "net/http"
require "uri"
class Job < ActiveRecord::Base
  belongs_to :mentor, class_name: "User"
  has_many :applications
  has_many :mentees, through: :applications
  validates :mentor_id, presence: true
  geocoded_by :address
  after_validation :geocode 
  
  def pretty_started_at
    self.started_at.strftime("%Y-%m-%d")
  end
  
  def pretty_finished_at
    self.finished_at.strftime("%Y-%m-%d")
  end
  
  def title_with_mentor
    self.title + " - " + self.mentor.name
  end
  
  def join_mentee(mentee)
    self.mentees << mentee
    self.send_sms(mentee)
  end

  def send_sms(mentee)
    message = "팜팜멘토 알림>>" + mentee.name + "님 께서" + self.title + " 작업 참여를 신청하셨습니다."
    uri = URI.parse("http://api.openapi.io/ppurio/1/message/sms/ffmentor")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.request_uri)
    req.content_type = 'application/x-www-form-urlencoded;'
    req['x-waple-authorization'] = Rails.application.secrets.sms_key
    time = (Time.now+5.seconds).strftime("%Y%m%d%H%M%S")
    req.set_form_data(
      "send_time" => time.to_s, 
      "dest_phone" => self.mentor.phone, 
      "send_phone" => mentee.phone, 
      "send_name" => mentee.name,
      "subject" => "신청",
      "apiVersion" => "1", 
      "id" => "ffmentor", 
      "msg_body" => message
    )
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      Rails.logger.info "@@@@@@ sms send OK"
      Rails.logger.info "@@@@@@ sender:" + mentee.name
      Rails.logger.info "@@@@@@ sender_phone:" + mentee.phone
      Rails.logger.info "@@@@@@ dest:" + self.mentor.phone
      return res
    else
      puts res.value
      return res
    end
  end

  
  def send_sms_test
    uri = URI.parse("http://api.openapi.io/ppurio/1/message/sms/ffmentor")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri.request_uri)
    req.content_type = 'application/x-www-form-urlencoded;'
    req['x-waple-authorization'] = "ODcwLTEzODQ3NzQ4OTg5NzEtOTQzZmM5YWQtNWMxYi00NTU3LWJmYzktYWQ1YzFiYjU1Nzlm"
    time = (Time.now+5.seconds).strftime("%Y%m%d%H%M%S")
    req.set_form_data(
      "send_time" => time.to_s, 
      "dest_phone" => "01064184332", 
      "send_phone" => "01064184332", 
      "send_name" => "이원섭",
      "subject" => "제목테스트",
      "apiVersion" => "1", 
      "id" => "ffmentor", 
      "msg_body" => "hello안녕안녕"
    )
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      puts "OK"
    else
      puts res.value
    end
  end
end
