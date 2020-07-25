require 'rails_helper'

RSpec.descirbe 'BoardCommentモデルのテスト', type: :model do
	describe 'バリデーションのテスト' do
		let(:user) { create(:user) }
		let(:board) { build(:board, user_id: user.id) }

		context 'commentカラム' do
			it '空欄でないこと' do
				comment.content = ''
				expect(board_comment.valid?).to eq false;
			end
		end
	end
end
