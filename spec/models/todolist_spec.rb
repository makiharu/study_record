require 'rails_helper'

RSpec.describe 'Todolistモデルのテスト', type: :model do

  describe 'バリデーションのテスト' do
  	let(:user) { create(:user) }
  	let(:todolist) { build(:todolist, user_id: user.id) }

  	context 'contentカラム' do
  	  it '空欄でないこと' do
  	  	todolist.content = ''
  	  	expect(todolist.valid?).to eq false;
  	  end
  	  it '30文字以上であること' do
  	  	todolist.content = Faker::Lorem.characters(number:31)
  	  	expect(todolist.valid?).to eq false;
  	  end
  	end
  end
end
