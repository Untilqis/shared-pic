class AlbumTagRelation < ApplicationRecord
  #アソシエーション
  belongs_to :album
  belongs_to :tag
  
  #バリデーション
  with_options presence: true do
    validates :album_id
    validates :tag_id
  end

end
