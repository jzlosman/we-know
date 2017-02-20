FactoryGirl.define do
  factory :fact do
    title { FFaker::Lorem.sentence }
    description { FFaker::Lorem.paragraph }
    user
  end
end
