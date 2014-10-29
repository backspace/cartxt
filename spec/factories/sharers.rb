FactoryGirl.define do
  factory :sharer do
    number 'Driver'
    status 'approved'

    trait :unknown do
      status 'unknown'
    end

    trait :rejected do
      status 'rejected'
    end

    trait :admin do
      role 'admin'
    end
  end
end
