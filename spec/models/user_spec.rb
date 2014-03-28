require 'spec_helper'

# describe Page do
#   it "목록을 가져와서 저장한다. user 토큰을 받아서." do
#     user_token = FactoryGirl.build(:test_token)[:user]
#     page_id = FactoryGirl.build(:test_token)[:page_uid]
#     page_ids = Page.create_or_update_page_list(user_token)
#     Page.create_or_update_page_list(user_token)
#     #한 user가 두 번 목록을 가져와도 중복으로 등록되지 않을 것.
#     expect(Page.where(uid: page_id).count).to eql(1) 
#     expect(Page.count).to be >= 1
#     expect(page_ids).to be_a_kind_of(Array)
#     
#   end
# end

describe User do
  it "페북 username을 입력하면 숫자로 된 uid 반환" do
    expect(User.fb_username_to_fb_id("onesup.lee")).to eql("100000987829488")
    expect(User.fb_username_to_fb_id("http://facebook.com/onesup.lee")).to eql("100000987829488")     
    expect(User.fb_username_to_fb_id("http://www.facebook.com/onesup.lee")).to eql("100000987829488")
    
  end
  it "끝에 /가 들어갔을 때" do
    expect(User.fb_username_to_fb_id("http://www.facebook.com/onesup.lee/")).to eql("100000987829488")
  end
end
