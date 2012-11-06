FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end

FactoryGirl.define do
  factory :company do
    sequence(:symbol)  { |n| "LC #{n}" }
    sequence(:name) { |n| "Legacy Iron Ore#{n}"}
  end
end