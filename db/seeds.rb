# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#ユーザーの作成
User.create!(

  email: "a@a.com",
  password: "matsuko",

  last_name: "小松",
  first_name: "真也",
  last_name_kana: "コマツ",
  first_name_kana: "シンヤ",
  postcode: "0000000",
  address: "大阪府枚方市1-11-11",
  phone_number: "00000000000",
  display_name: "マジシャンマツコ",
  description: "よろしくお願いします！",
  is_deleted: false
)

User.create!(

  email: "b@b.com",
  password: "matsuko",

  last_name: "小松",
  first_name: "真也",
  last_name_kana: "コマツ",
  first_name_kana: "シンヤ",
  postcode: "0000000",
  address: "大阪府東大阪市1-11-11",
  phone_number: "00000000000",
  display_name: "マジシャンツマコ",
  description: "よろしくお願いします！",
  is_deleted: false
)

User.create!(

  email: "c@c.com",
  password: "matsuko",

  last_name: "小松",
  first_name: "真也",
  last_name_kana: "コマツ",
  first_name_kana: "シンヤ",
  postcode: "0000000",
  address: "大阪府寝屋川市1-11-11",
  phone_number: "00000000000",
  display_name: "マジシャンコマツ",
  description: "よろしくお願いします！",
  is_deleted: false
)


User.create!(

  email: "d@d.com",
  password: "matsuko",

  last_name: "小松",
  first_name: "真也",
  last_name_kana: "コマツ",
  first_name_kana: "シンヤ",
  postcode: "0000000",
  address: "大阪府八尾市1-11-11",
  phone_number: "00000000000",
  display_name: "クリエイターマツコ",
  description: "よろしくお願いします！",
  is_deleted: false
)


#ジャンルデータの作成
Genre.create!(
  name: "カードマジック"
)

Genre.create!(
  name: "コインマジック"
)

Genre.create!(
  name: "その他クロースアップ"
)

Genre.create!(
  name: "サロン"
)

Genre.create!(
  name: "ステージ"
)

Genre.create!(
  name: "書籍"
)

Genre.create!(
  name: "DVD"
)

Genre.create!(
  name: "その他・消耗品等"
)