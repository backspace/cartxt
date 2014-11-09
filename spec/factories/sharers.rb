FactoryGirl.define do
  sequence :number do |n|
    "##{n}"
  end

  factory :sharer do
    number
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
