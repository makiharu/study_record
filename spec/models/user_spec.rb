require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗

  describe 'バリデーションのテスト' do
  	let(:user) { build(:user) }
  	subject { test_user.valid? }
  	context 'nameカラム' do
  		let(:test_user) { user }
  		it '空欄でないこと' do
  			test_user.name = ''
  			is_expected.to eq false;
  		end
  		it '2文字以上であること' do
  			test_user.name = Faker::Lorem.characters(number:1)
  			is_expected.to eq false;
  		end
  		it '20文字以下であること' do
  			test_user.name = Faker::Lorem.characters(number:21)
  			is_expected.to eq false;
  		end
  	end

  	context 'introductionカラム' do
  		let(:test_user) { user }
  		it '50文字以下であること' do
  			test_user.introduction = Faker::Lorem.characters(number:51)
  			is_expected.to eq false
  		end
  	end

    context "データが正しく保存される" do
      before do
        @user = User.new
        @user.name = "hogeo"
        @user.introduction = "今日も晴れです。"
        @user.save
      end
      it "全て入力してあるので保存される" do
        expect(@user).to be_valid
      end
    end
  end
end
