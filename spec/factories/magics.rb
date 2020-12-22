FactoryBot.define do
  factory :magic do
    user
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:100) }
    video { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.mp4')) }
  end
end

