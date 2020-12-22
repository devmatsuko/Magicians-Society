FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    first_name { person.first.kanji }
    last_name { person.last.kanji }
    first_name_kana { person.first.katakana }
    last_name_kana { person.last.katakana }
    postcode { "0000000" }
    address { Faker::Address.full_address }
    phone_number { "00000000000" }
    display_name { Faker::Internet.user_name }
    description { "よろしくお願いします！"}
    is_deleted { false }
  end

end

