role = Role.create!(
  name: :admin,
  title: "role for admin",
  description:"this user can do anything"
)
Role.create!(
  name: :mentor,
  title: "role for mentor",
  description:"mentor role"
)
Role.create!(
  name: :mentee,
  title: "role for mentee",
  description:"mentee role"
)
role.create_rule(:system, :administrator)
role.rule_on(:system, :administrator)

puts "Admin role created"

admin = User.create!(email:'admin@farmfarmmentor.org', password:'123123123', role_id: 1)
admin = User.create!(email:'0nesup@naver.com', uid: "100001176058018", password:'123123123', role_id: 1)



User.first.update( role: Role.with_name(:admin) )
puts "created #{User.first.email} and that made administer"

titles = %w(사과 배 포도 복숭아 멜론 깻잎 호박 옥수수)
emails = %w(apple pear grape peach melon sesame pumpkin corn)
categories = %w(식량 채소 특작 과수 기타)
contents = " 내용입니다."
address = [
  "전라북도 순창군 순창읍 경천로 33",
  "전라북도 순창군 북흥면",
  "전라북도 순창군 쌍치면",
  "전라북도 순창군 구림면",
  "전라북도 순창군 인계면",
  "전라북도 순창군 적성면",
  "전라북도 순창군 동계면",
  "전라북도 순창군 팔덕면",
]
day = Time.now + [1,6,16,21,30].shuffle[0].days
i = 0
titles.each do |title|

  Answer.create!(title: title, contents: title + contents)
  Notice.create!(title: title, contents: title + contents)
  Question.create!(title: title, contents: title + contents)
  review = Review.new(title: title, contents: title + contents)
  banner = Banner.new(title: title, contents: title + contents)
  banner.banner_image = open(Rails.root.to_s + "/public/img/" + 'banner' + i.to_s + '.jpg')
  banner.save!
  
  mentor = User.new(name: "김"+title, email: emails[i]+"@gmail.com", password:"123123123")
  mentor.avatar = open(Rails.root.to_s + "/public/img/" + 'farmer' + i.to_s + '.png')
  mentor.role = Role.find_by_name("mentor")
  mentor.save!
  puts mentor.name
  mentee = User.new(name: "멘티 박"+title, email: emails[i]+"@naver.com", password:"123123123")
  mentee.role = Role.find_by_name("mentee")
  mentee.save!
  review.user = mentee
  categories.shuffle[1..2].each do |category|
    job = mentor.works.create!( title: title, contents: title + contents, category: category,
                          started_at: Time.now + [1,6,16,21,30].shuffle[0].days, finished_at: day + 1.day, 
                          location: "마을회관 앞", address: address[i])
    job.mentees << mentee
    review.job = job
    review.save
  end
  puts mentee.name
  i = i + 1
end