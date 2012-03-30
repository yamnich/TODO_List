# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name ){|n| "user_name_#{n}"}
    sequence(:email){|n| "email#{n}@test.ua"}
    password "password"
  end
end
