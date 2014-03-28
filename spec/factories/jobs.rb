# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    category "MyString"
    title "MyString"
    content "MyText"
    time "MyText"
    level "MyString"
    workers_count 1
    pay 1
    address "MyString"
  end
end
