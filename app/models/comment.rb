class Comment < ApplicationRecord
  #アソシエーション
  belongs_to :user
  belongs_to :album

  #バリデーション
  with_options presence: true do
    validates :content
    validates :album
    validates :user
  end
  
end
