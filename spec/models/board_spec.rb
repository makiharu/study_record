require 'rails_helper'

RSpec.describe 'Boardモデルのテスト', type: :model do
	describe 'バリデーションのテスト' do
		#buildとcreateについて
	  let(:user) { create(:user) }
	  let(:board) { build(:board, user_id: user.id)}

	  context 'titleカラム' do
	  	it '空欄でないこと' do
	  	  board.title = ''
	  	  expect(board.valid?).to eq false;
	  	end
	  end

	  context 'bodyカラム' do
	  	it '空欄でないこと' do
		  board.body = ''
		  expect(board.valid?).to eq false;
		end
		it '50文字以下であること' do
		  board.title = Faker::Lorem.characters(number:51)
		  expect(board.valid?).to eq false;
		end

		it '1500文字以下であること' do
		  board.body = Faker::Lorem.characters(number:1501)
		  expect(board.valid?).to eq false;
		end
	  end
	end
	describe 'アソシーエーションのテスト' do
	  context 'Userモデルとの関係' do
	    it 'N:1となっている' do
	      expect(Board.reflect_on_association(:user).macro).to eq :belongs_to
	    end
	  end
	end
end



#example の中ではインスタンス変数を使わない方がよい
