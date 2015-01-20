FactoryGirl.define do


  factory :user do
    pswrd = "BlahBlah"
    fake_email = Faker::Internet.email
    sequence(:email) { |n| "#{n}#{fake_email}" }
    sequence(:email_confirmation) { |n| "#{n}#{fake_email}" }
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password pswrd
    password_confirmation pswrd
  end
end