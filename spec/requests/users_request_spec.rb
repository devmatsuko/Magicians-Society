require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  describe "非ログイン状態でのページアクセステスト" do
    describe "ユーザー一覧ページ" do
      context "新規投稿ページが正しく表示される" do
        before do
          visit users_path
        end
        it 'タイトルにMagiciansと表示される' do
          page.has_content?('Magicians')
        end
      end
    end

    describe "ユーザー詳細ページ" do
      context "ページが正しく表示される" do
        before do
          visit user_path(user)
        end
        it 'タイトルにProfileと表示される' do
          page.has_content?('Profile')
        end
        it 'チャットを始めるボタンがある' do
          page.has_content?('チャットを始める')
        end
        it 'プロフィール編集ボタンが無い' do
          page.has_no_content?('プロフィール編集')
        end
        it '注文履歴ボタンが無い' do
          page.has_no_content?('注文履歴')
        end
        it '販売履歴ボタンが無い' do
          page.has_no_content?('販売履歴')
        end
      end
    end

    describe "ユーザー編集ページ" do
      context "非ログイン状態ではアクセスできない" do
        before do
          visit edit_user_path(user)
        end
        it 'ログインページへリダイレクトされる。' do
          expect(current_path).to eq(new_user_session_path)
        end
      end
    end

    describe "ユーザー退会ページ" do
      context "非ログイン状態ではアクセスできない" do
        before do
          visit withdrawal_users_path
        end
        it 'ログインページへリダイレクトされる。' do
          expect(current_path).to eq(new_user_session_path)
        end
      end
    end

    # ログインのテスト
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      it 'ログインに成功する' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Login'

        page.has_content? 'ログインしました。'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'Login'
        # ログインページへリダイレクトされる。
        expect(current_path).to eq(new_user_session_path)
      end
    end

  end

  describe "ログイン状態でのページアクセステスト" do

    # ログインする
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Login'
    end

    describe "ユーザー一覧ページ" do
      context "新規投稿ページが正しく表示される" do
        before do
          visit users_path
        end
        it 'タイトルにMagiciansと表示される' do
          page.has_content?('Magicians')
        end
      end
    end

    describe "マイページ" do
      context "ページが正しく表示される" do
        before do
          visit user_path(user2)
        end
        it 'タイトルにMyPageと表示される' do
          page.has_content?('MyPage')
        end
        it 'チャットルームへボタンがある' do
          page.has_content?('チャットルームへ')
        end
        it 'プロフィール編集ボタンがある' do
          page.has_content?('プロフィール編集')
        end
        it '注文履歴ボタンがある' do
          page.has_content?('注文履歴')
        end
        it '販売履歴ボタンがある' do
          page.has_content?('販売履歴')
        end
      end
    end

    describe "他ユーザー詳細ページ" do
      context "ページが正しく表示される" do
        before do
          visit user_path(user2)
        end
        it 'タイトルにProfileと表示される' do
          page.has_content?('Profile')
        end
        it 'チャットを始めるボタンがある' do
          page.has_content?('チャットを始める')
        end
        it 'プロフィール編集ボタンが無い' do
          page.has_no_content?('プロフィール編集')
        end
        it '注文履歴ボタンが無い' do
          page.has_no_content?('注文履歴')
        end
        it '販売履歴ボタンが無い' do
          page.has_no_content?('販売履歴')
        end
      end
    end

    describe "カレントユーザー編集ページ" do
      context "ページが正しく表示される" do
        before do
          visit edit_user_path(user)
        end
        it 'タイトルにEdit Profileと表示される' do
          page.has_content?('Edit Profile')
        end
        it 'プロフィール更新に成功する' do
          click_button '更新'
          page.has_content? 'ユーザー情報を更新しました。'
          page.has_content?('MyPage')
        end
        it 'プロフィール更新に失敗する' do
          fill_in 'user[first_name]', with: ''
          click_button '更新'
          page.has_content? '姓を入力してください'
          page.has_content?('Edit Profile')
        end
      end
    end

    describe "他ユーザー編集ページ" do
      context "アクセス制限によりマイページに遷移する。" do
        before do
          visit edit_user_path(user2)
        end
        it '権限がありませんと表示される' do
          page.has_content? '権限がありません。'
        end
        it 'タイトルにMyPageと表示される' do
          page.has_content?('MyPage')
        end
      end
    end

    describe "ユーザー退会ページ" do
      context "ページが正しく表示される" do
        before do
          visit withdrawal_users_path(user)
        end
        it 'タイトルにDelete your account?と表示される' do
          page.has_content?('Delete your account?')
        end
      end
    end

    describe "カレントユーザー退会処理" do
      context "ページが正しく表示される" do
        before do
          patch withdrawal_user_path(user)
        end
        it 'ありがとうございました。またのご利用を心よりお待ちしております。と表示される' do
          page.has_content?('ありがとうございました。またのご利用を心よりお待ちしております。')
        end
      end
    end

    describe "他ユーザー退会処理" do
      context "アクセス制限によりマイページに遷移する" do
        before do
          patch withdrawal_user_path(user2)
        end
        it '権限がありませんと表示される' do
          page.has_content? '権限がありません。'
        end
        it 'タイトルにMyPageと表示される' do
          page.has_content?('MyPage')
        end
      end
    end

    describe "ログアウトする" do
      before do
        visit destroy_user_session_path(user)
      end
      it 'ログアウトしましたと表示される' do
        page.has_content? 'ログアウトしました。'
      end
    end

  end
end