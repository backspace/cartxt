FactoryGirl.define do
  factory :car do
    number 'Bot'

    trait :borrowed do
      status 'borrowed'
    end
  end
end
