class Tag < ApplicationRecord
 
  #アソシエーション
  has_many :album_tag_relations
  has_many :albums, through: :album_tag_relations
  
  #バリデーション
  validates :tag_name, uniqueness: true
  
end
