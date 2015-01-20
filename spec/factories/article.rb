FactoryGirl.define do

  factory :article do
    title  Faker::Lorem.words(5).join(" ")
    content Faker::Lorem.paragraphs(5).join("\n")
  end
end