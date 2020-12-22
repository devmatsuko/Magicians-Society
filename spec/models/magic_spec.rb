require 'rails_helper'

RSpec.describe 'Magicモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:test_magic) { build(:magic) }
    it '全ての項目に適切な値が入力されている場合は新規登録できる' do
      expect(test_magic).to be_valid
    end

    context 'titleカラム' do
      it '空欄の場合はエラー' do
        test_magic.title = ''
        expect(test_magic).not_to be_valid
      end
      it '20文字の場合はOK' do
        test_magic.title = Faker::Lorem.characters(number:20)
        expect(test_magic).to be_valid
      end
      it '20文字以下で無い場合はエラー' do
        test_magic.title = Faker::Lorem.characters(number:21)
        expect(test_magic).not_to be_valid
      end
    end

    context 'bodyカラム' do
      it '空欄の場合はエラー' do
        test_magic.body = ''
        expect(test_magic).not_to be_valid
      end
      it '200文字の場合はOK' do
        test_magic.body = Faker::Lorem.characters(number:200)
        expect(test_magic).to be_valid
      end
      it '201文字以下で無い場合はエラー' do
        test_magic.body = Faker::Lorem.characters(number:201)
        expect(test_magic).not_to be_valid
      end
    end

    context 'videoカラム' do
      it '空欄の場合はエラー' do
        test_magic.video = ''
        expect(test_magic).not_to be_valid
      end
    end

  end
end
