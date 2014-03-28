# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :application do
    user nil
    job nil
    confirm false
    confirmed_at "2013-09-12 11:06:01"
  end
end
