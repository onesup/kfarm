require 'spec_helper'

describe Job do
  it "mentor 가 올린 일자리 정보 뽑아내기" do
    mentor = User.create(name: "이수형", email: "onesup.lee@gmail.com", password: "123123123");
    mentor.works.create(title: "사과")
    mentor.works.create(title: "복숭아")
    mentor.works.create(title: "단감")
    expect(mentor.current_works.count).to eql(3)
  end

end
