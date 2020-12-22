FactoryBot.define do
  factory :product do
    association :user
    association :genre
    name { Faker::Lorem.characters(number:10) }
    explanation { Faker::Lorem.characters(number:100) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/show.jpg')) }
    product_status { 0 }
    price { Faker::Number.number(digits: 4) }
    is_sale { true }
    shipping_method { 0 }
    shipping_date { 0 }
    postage_status { 0 }
  end
end