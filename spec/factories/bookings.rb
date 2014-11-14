FactoryGirl.define do
  factory :booking do
    status 'confirmed'

    trait :current do
      begins_at Time.now - 1.hour
      ends_at Time.now + 1.hour
    end
  end
end
