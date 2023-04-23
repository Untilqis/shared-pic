class Album < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :album_tag_relations
  has_many :tags, through: :album_tag_relations
  
end
