require 'rails_helper'

RSpec.describe Album, type: :model do
  before do
    @album = FactoryBot.build(:album)
  end

  describe '投稿機能' do
    context '投稿ができる時' do
      it 'title,description,image,user_idが存在すれば登録できる' do
        expect(@album).to be_valid
      end
    end

    context '投稿ができない時' do
      it 'タイトルが空では登録できない' do
        @album.title = ''
        @album.valid?
        expect(@album.errors.full_messages).to include("タイトルを入力してください")
      end

      it '説明が空では登録できない' do
        @album.description = ''
        @album.valid?
        expect(@album.errors.full_messages).to include("説明を入力してください")
      end

      it '画像が空では登録できない' do
        @album.image = nil
        @album.valid?
        expect(@album.errors.full_messages).to include("画像を入力してください")
      end

      it 'userが紐づいていないと登録できない' do
        @album.user = nil
        @album.valid?
        expect(@album.errors.full_messages).to include('ユーザー情報を入力してください')
      end
    end
  end
end
