FactoryGirl.define do
  factory :user do
    sequence(:name ){|n| "user_name_#{n}"}
    sequence(:email){|n| "email#{n}@test.ua"}
    password "password"
  end
end