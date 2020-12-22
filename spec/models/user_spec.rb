require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:test_user) { build(:user) }
    it '全ての項目に適切な値が入力されている場合は新規登録できる' do
      expect(test_user).to be_valid
    end

    context 'passwordカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.password = ''
        expect(test_user).not_to be_valid
      end
      it 'パスワードが同一で無い場合はエラー' do
        test_user.password = 'P@ssword'
        test_user.password_confirmation = 'Password'
        expect(test_user).not_to be_valid
      end
    end

    context 'display_nameカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.display_name = ''
        expect(test_user).not_to be_valid
      end
      it '20文字の場合はOK' do
        test_user.display_name = Faker::Lorem.characters(number:20)
        expect(test_user).to be_valid
      end
      it '20文字以下で無い場合はエラー' do
        test_user.display_name = Faker::Lorem.characters(number:21)
        expect(test_user).not_to be_valid
      end
    end

    context 'descriptionカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.description = ''
        expect(test_user).not_to be_valid
      end
      it '200文字の場合はOK' do
        test_user.description = Faker::Lorem.characters(number:200)
        expect(test_user).to be_valid
      end
      it '200文字以下で無い場合はエラー' do
        test_user.description = Faker::Lorem.characters(number:201)
        expect(test_user).not_to be_valid
      end
    end

    context 'last_nameカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.last_name = ''
        expect(test_user).not_to be_valid
      end
    end

    context 'first_nameカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.first_name = ''
        expect(test_user).not_to be_valid
      end
    end

    context 'last_name_kanaカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.last_name_kana = ''
        expect(test_user).not_to be_valid
      end
    end

    context 'first_name_kanaカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.first_name_kana = ''
        expect(test_user).not_to be_valid
      end
    end

    context 'emailカラム' do
      let(:test_user) { build(:user) }
      let(:user1) { create(:user) }
      it '空欄の場合はエラー' do
        test_user.email = ''
        expect(test_user).not_to be_valid
      end
      it 'emailが重複している場合は登録できない' do
        test_user.email = user1.email
        expect(test_user).not_to be_valid
      end

    end

    context 'postcodeカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.postcode = ''
        expect(test_user).not_to be_valid
      end
      it '7文字の数字である場合はOK' do
        test_user.postcode = Faker::Number.number(digits: 7)
        expect(test_user).to be_valid
      end
      it '6文字である場合はエラー' do
        test_user.postcode = Faker::Number.number(digits: 6)
        expect(test_user).not_to be_valid
      end
      it '8文字である場合はエラー' do
        test_user.postcode = Faker::Number.number(digits: 8)
        expect(test_user).not_to be_valid
      end
      it '数字以外である場合はエラー' do
        test_user.postcode = Faker::Lorem.characters(number:7)
        expect(test_user).not_to be_valid
      end
    end

    context 'addressカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.address = ''
        expect(test_user).not_to be_valid
      end
    end

    context 'phone_numberカラム' do
      let(:test_user) { build(:user) }
      it '空欄の場合はエラー' do
        test_user.phone_number = ''
        expect(test_user).not_to be_valid
      end
      it '数字以外である場合はエラー' do
        test_user.postcode = Faker::Lorem.characters(number:11)
        expect(test_user).not_to be_valid
      end
    end
  end

end
