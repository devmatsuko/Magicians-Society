require 'rails_helper'

RSpec.describe 'Productモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
    let(:test_product) { build(:product) }
    it '全ての項目に適切な値が入力されている場合は新規登録できる' do
      expect(test_product).to be_valid
    end

    context 'nameカラム' do
      it '空欄の場合はエラー' do
        test_product.name = ''
        expect(test_product).not_to be_valid
      end
      it '20文字の場合はOK' do
        test_product.name = Faker::Lorem.characters(number:20)
        expect(test_product).to be_valid
      end
      it '20文字以下で無い場合はエラー' do
        test_product.name = Faker::Lorem.characters(number:21)
        expect(test_product).not_to be_valid
      end
    end

    context 'explanationカラム' do
      it '空欄の場合はエラー' do
        test_product.explanation = ''
        expect(test_product).not_to be_valid
      end
      it '200文字の場合はOK' do
        test_product.explanation = Faker::Lorem.characters(number:200)
        expect(test_product).to be_valid
      end
      it '201文字以下で無い場合はエラー' do
        test_product.explanation = Faker::Lorem.characters(number:201)
        expect(test_product).not_to be_valid
      end
    end

    context 'genreカラム' do
      it '空欄の場合はエラー' do
        test_product.genre = nil
        expect(test_product).not_to be_valid
      end
    end

    context 'product_status' do
      it '空欄の場合はエラー' do
        test_product.product_status = ''
        expect(test_product).not_to be_valid
      end
    end

    context 'price' do
      it '空欄の場合はエラー' do
        test_product.price = ''
        expect(test_product).not_to be_valid
      end
      it '数字以外である場合はエラー' do
        test_product.price = Faker::Lorem.characters(number:5)
        expect(test_product).not_to be_valid
      end
    end

    context 'shipping_method' do
      it '空欄の場合はエラー' do
        test_product.shipping_method = ''
        expect(test_product).not_to be_valid
      end
    end

    context 'shipping_date' do
      it '空欄の場合はエラー' do
        test_product.shipping_date = ''
        expect(test_product).not_to be_valid
      end
    end

    context 'postage_status' do
      it '空欄の場合はエラー' do
        test_product.postage_status = ''
        expect(test_product).not_to be_valid
      end
    end

    context 'image' do
      it '空欄の場合はエラー' do
        test_product.image = ''
        expect(test_product).not_to be_valid
      end
    end

    context 'is_sale' do
      it '空欄の場合はエラー' do
        test_product.is_sale = ''
        expect(test_product).not_to be_valid
      end
    end


  end
end
