FactoryGirl.define do
  factory :borrowing do
    initial 100
    final 200

    trait :incomplete do
      final nil
    end
  end
end
