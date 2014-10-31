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

    trait :notified_of_bookings do
      notify_of_bookings true
    end
  end
end
