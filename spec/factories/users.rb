FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    name "Test User"
    email
    password "please123"

    trait :admin do
      role 'admin'
    end

  end
end
