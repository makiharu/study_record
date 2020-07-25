require 'rails_helper'

RSpec.describe 'BoardCommentモデルのテスト', type: :model do
	describe 'バリデーションのテスト' do
		let(:user) { create(:user) }
		let(:board) { create(:board, user_id: user.id) }
		let(:board_comment) { build(:board_comment, user_id: user.id, board_id: board.id) }

		context 'commentカラム' do
			it '空欄でないこと' do
				board_comment.content = ''
				expect(board_comment.valid?).to eq false;
			end

			it '1500文字以下であること' do
				board_comment.content = Faker::Lorem.characters(number:1501)
				expect(board_comment.valid?).to eq false;
			end
		end
	end
end
