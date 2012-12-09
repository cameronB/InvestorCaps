FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"

    factory :admin do
      admin true
    end
  end

  factory :post do
      symbol "LCY"
      title "Annoucement out guys!"
      content "Check it out guys, LCY bought out Mount Bevan from Hawthorn Resources!"
      user
    end
  end

  FactoryGirl.define do
    factory :company do
      symbol  "Lcy"
      name    "Legacy Iron Ore"
    end
  end