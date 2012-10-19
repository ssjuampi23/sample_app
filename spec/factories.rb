FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end #end admin factory
  end #end user factory
  
  factory :micropost do
    content "Lorem ipsum"
    user
  end
  
end #end factory Girl