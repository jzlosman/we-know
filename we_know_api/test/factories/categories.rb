FactoryGirl.define do
  factory :category do
      label { FFaker::Lorem.sentence }
      description { FFaker::Lorem.paragraph }
  end
end
