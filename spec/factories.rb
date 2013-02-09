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
      title "Annoucement out!"
      content "Annoucement out!"
      user
  end

  factory :company do
     symbol  "LCY"
     name    "Legacy Iron Ore"
  end

  factory :comment do
      message "Awesome Annoucement"
  end

end