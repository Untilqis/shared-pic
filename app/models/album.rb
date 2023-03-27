class Album < ApplicationRecord
  #アソシエーション
  belongs_to :user
  #has_many :comments, dependent: :destroy
  #has_one_attached :image
  
  #バリデーション
  validates :title,      presence: true
  validates :description, presence: true
  validates :image,      presence: true
end
