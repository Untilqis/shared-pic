class Album < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  
  #バリデーション
  with_options presence: true do
    validates :title
    validates :description
    validates :image
  end
  
end
